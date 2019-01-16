---
title: Bootstrapping an Ubuntu Server on Rackspace Using Cloud-Init and Fog
author: Jeff Gran
layout: post
permalink: /276/blog/ubuntu-cloud-init-rackspace-fog-ruby
tags: ruby cloud Web
---
# Bootstrapping an Ubuntu Server on Rackspace Using Cloud-Init and Fog

Recently at work I needed to figure out how to bootstrap a server image on Rackspace, preferably using Ubuntu’s Cloud-Init package since we already had that working on EC2.

I couldn’t find a single person who had done this before, so after struggling for a day or two and finally figuring out that it does indeed work (and it turns out to be pretty simple) I thought I would share the knowledge on how to do it.

### Set up the Machine Image

EC2 has ready-made Ubuntu images with Cloud-Init already installed, but for Rackspace the first thing you need to do is create a similar image. All we did was to get a stock Ubuntu image (11.04) and run `apt-get install cloud-init` on it.

That’s it. Then just save out that image to your account.

### Bootstrap the Image with Fog

Note: We’re using Ruby, so we can use the awesome [Fog gem][1] as a wrapper around the [Rackspace REST API][2], but you could also accomplish the same thing with the raw API.

 [1]: https://github.com/geemus/fog
 [2]: http://docs.rackspace.com/servers/api/v1.0/cs-devguide/content/Create_Server-d1e1937.html

A couple of notes, and then I’ll show the code:

*   We are generating an SSH key-pair to initialize the server with. This is not strictly required, but if you don’t do this, you must save the password attribute of the returned server object on the initial create call. Subsequent queries against the server will not return the password for security reasons.


*   The `personality` field is the crux of this process. It allows you to send up to 5 files to be put on the server in a location of your choosing at boot time. It turns out that this can be used to "seed" cloud-init with the files it needs, mimicking the `user-data` field you would pass to EC2. Note that the path to the file you supply does not have to exist on the image. Rackspace will create the directories for you if they don't.


*   The path where you put the files is also important. In the code below the `/nocloud-net/` part of the path can be interchanged with a few others, though I’m not sure what some of them mean. Don’t quote me on this, but I believe that `/nocloud/` is supposed to mean that you’re not in the cloud, and `/nocloud-net/` is the same, except that you are guaranteed that you will have a connection to the internet when it runs (a little bit later in the boot process than `nocloud`). But we can hijack either one for our use in seeding cloud-init.


*   Very important: you must supply BOTH the `user-data` and the `meta-data` files in order for cloud-init to run. In EC2, [the meta-data file][3] has a bunch of EC2-specific data in it (and some generic data, to be fair), but I found that we didn’t need any of that data and the defaults worked fine. But you still have to create that file, and an empty string doesn’t work (the file doesn’t get created), which is why we have specified a single space for the contents of the file.

 [3]: http://bazaar.launchpad.net/~cloud-init-dev/cloud-init/trunk/view/head:/doc/examples/seed/meta-data


*   The `user-data` file can be any type of file that cloud-init normally expects, including the multi-part format, so you can include multiple files that way. The code below shows how we compiled some files from the local file system into a multipart document (each with the appropriate `#` or `#!` header). See the [cloud-init documentation][4] for more info.

 [4]: https://help.ubuntu.com/community/CloudInit

~~~~ ruby
# get a handle to the fog compute abstraction
compute_adapter = Fog::Compute.new({
  provider: "Rackspace",
  rackspace_api_key: "",
  rackspace_username: ""
})
 
# generate the ssh key-pair
keys = SSHKey.generate
 
# let's make a multi-part document
scripts = MIME::MultipartMedia::Mixed.new
 
# assuming `files` is an array of File objects corresponding
# to real, properly formatted cloud-init script files
files.each do |f| do
  scripts.add_entity(MIME::TextMedia.new(file, "text/plain"))
end
 
compute_adapter.servers.bootstrap({
  image_id: 39,
  flavor_id: 1,
  name: "A Name for the Server",
  personality: [
    {
      'path' =>
        '/var/lib/cloud/seed/nocloud-net/user-data',
      'contents' => scripts.to_s
    },{
      'path' =>
        '/var/lib/cloud/seed/nocloud-net/meta-data',
      'contents' => ' '
    }
  ],
  public_key: keys.ssh_public_key,
  private_key: keys.private_key
)
~~~~

### Helpful links:

*   [Cloud-init project with source code browser (including example files)][5]
*   [Fog Documentation][6]
*   [sshkey gem used to generate the proper type of keys][7]

 [5]: https://code.launchpad.net/~cloud-init-dev/cloud-init/trunk
 [6]: http://fog.io/0.10.0/rdoc/Fog/Compute/Rackspace/Server.html
 [7]: https://github.com/bensie/sshkey
