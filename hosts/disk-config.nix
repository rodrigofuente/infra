{
    disko.devices.disk = {
    main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
        type = "gpt";
        partitions = {
            ESP = {
            priority = 1;
            label = "ESP";
            size = "1G";
            type = "EF00";
            content = {
                type = "filesystem";
                format = "vfat";
                extraArgs = [
                "-F32"
                "-nESP"
                ];
            mountpoint = "/boot";
            mountOptions = [ "umask=0077" ];
            };
            };
            root = {
            label = "root";
            size = "100%";
            content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                mountpoint = "/";
            };
            };
        };
        };
    };
    };
}
