# -*- mode: ruby -*-
# vi: set ft=ruby :
require "json"


# load the config
json = JSON.parse(File.read("/home/#{ENV['USER']}/git/config.json"))

Vagrant.configure("2") do |config|
    # for each box in the config,
    json["boxes"].each.with_index do |(box,options), i|
        #puts("[#{i}] #{box}: #{options}")

        # if there is a custom name, use it, otherwise construct one
        name = options["name"] || "#{json['prefix'] || 'dev'}#{i}"

        # if global mounts are defined
        if json["mounts"] then
            # construct a config line for each of them
            json["mounts"].each do |mount|
                host = mount["host"] || "~/git/build/#{name}"
                guest = mount["guest"]
                mode = mount["mode"] || []
                config.vm.synced_folder host, guest, :mount_options => mode
            end
        end

        # define a new vagrant config with name
        config.vm.define name, autostart: options["autostart"] do |box|
            # load the box source
            box.vm.box = options["source"] || "scotch/box"

            # set the hostname
            box.vm.hostname = options["hostname"] || name

            # set the network
            if options["ip"] then
                box.vm.network json["network"]["type"], :use_dhcp_assigned_default_route => true, bridge: json["network"]["bridge"], ip: options["ip"]
            else
                box.vm.network json["network"]["type"], :use_dhcp_assigned_default_route => true, bridge: json["network"]["bridge"]
            end

            # set the port forward if needed
            if options["port"] then
                box.vm.network "forwarded_port", host: (options["port"]+i) , guest: options["port"]
            end

            # if box mounts are defined
            if options["mounts"] then
                options["mounts"].each do |mount|

                    # load mount information
                    host = File.expand_path(mount["host"])
                    guest = mount["guest"]
                    mode = mount["mode"] || []

                    # mount
                    box.vm.synced_folder host, guest, :mount_options => mode
                end
            end
        end
    end
end
