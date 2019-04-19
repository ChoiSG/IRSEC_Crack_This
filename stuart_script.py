#!/usr/bin/python
import subprocess
import re
import os

known_services = {
"proc-sys-fs-binfmt_misc.automount",
"dev-hugepages.mount",
"dev-mqueue.mount",
"proc-sys-fs-binfmt_misc.mount",
"run-vmblock\\x2dfuse.mount",
"sys-fs-fuse-connections.mount",
"sys-kernel-config.mount",
"sys-kernel-debug.mount",
"acpid.path",
"cups.path",
"systemd-ask-password-console.path",
"systemd-ask-password-plymouth.path",
"systemd-ask-password-wall.path",
"systemd-networkd-resolvconf-update.path",
"accounts-daemon.service",
"acpid.service",
"alsa-restore.service",
"alsa-state.service",
"alsa-utils.service",
"anacron-resume.service",
"anacron.service",
"apport-forward@.service",
"apt-daily-upgrade.service",
"apt-daily.service",
"autovt@.service",
"avahi-daemon.service",
"bluetooth.service",
"bootlogd.service",
"bootlogs.service",
"bootmisc.service",
"brltty-udev.service",
"brltty.service",
"checkfs.service",
"checkroot-bootclean.service",
"checkroot.service",
"colord.service",
"console-getty.service",
"console-setup.service",
"console-shell.service",
"container-getty@.service",
"cron.service",
"cryptdisks-early.service",
"cryptdisks.service",
"cups-browsed.service",
"cups.service",
"dbus-org.bluez.service",
"dbus-org.freedesktop.Avahi.service",
"dbus-org.freedesktop.hostname1.service",
"dbus-org.freedesktop.locale1.service",
"dbus-org.freedesktop.login1.service",
"dbus-org.freedesktop.network1.service",
"dbus-org.freedesktop.nm-dispatcher.service",
"dbus-org.freedesktop.resolve1.service",
"dbus-org.freedesktop.thermald.service",
"dbus-org.freedesktop.timedate1.service",
"dbus.service",
"debug-shell.service",
"display-manager.service",
"dns-clean.service",
"emergency.service",
"failsafe-x.service",
"friendly-recovery.service",
"fuse.service",
"fwupd-offline-update.service",
"fwupd.service",
"fwupdate-cleanup.service",
"getty-static.service",
"getty@.service",
"gpu-manager.service",
"halt.service",
"hostname.service",
"hwclock.service",
"ifup@.service",
"initrd-cleanup.service",
"initrd-parse-etc.service",
"initrd-switch-root.service",
"initrd-udevadm-cleanup-db.service",
"kerneloops.service",
"keyboard-setup.service",
"killprocs.service",
"kmod-static-nodes.service",
"kmod.service",
"lightdm.service",
"ModemManager.service",
"module-init-tools.service",
"motd.service",
"mountall-bootclean.service",
"mountall.service",
"mountdevsubfs.service",
"mountkernfs.service",
"mountnfs-bootclean.service",
"mountnfs.service",
"network-manager.service",
"networking.service",
"NetworkManager-dispatcher.service",
"NetworkManager-wait-online.service",
"NetworkManager.service",
"open-vm-tools.service",
"plymouth-halt.service",
"plymouth-kexec.service",
"plymouth-log.service",
"plymouth-poweroff.service",
"plymouth-quit-wait.service",
"plymouth-quit.service",
"plymouth-read-write.service",
"plymouth-reboot.service",
"plymouth-start.service",
"plymouth-switch-root.service",
"plymouth.service",
"polkitd.service",
"pppd-dns.service",
"procps.service",
"quotaon.service",
"rc-local.service",
"rc.local.service",
"rc.service",
"rcS.service",
"reboot.service",
"rescue.service",
"resolvconf.service",
"rmnologin.service",
"rsync.service",
"rsyslog.service",
"rtkit-daemon.service",
"saned.service",
"saned@.service",
"sendsigs.service",
"serial-getty@.service",
"setvtrgb.service",
"sigpwr-container-shutdown.service",
"single.service",
"snapd.autoimport.service",
"snapd.core-fixup.service",
"snapd.failure.service",
"snapd.seeded.service",
"snapd.service",
"snapd.snap-repair.service",
"snapd.system-shutdown.service",
"stop-bootlogd-single.service",
"stop-bootlogd.service",
"syslog.service",
"systemd-ask-password-console.service",
"systemd-ask-password-plymouth.service",
"systemd-ask-password-wall.service",
"systemd-backlight@.service",
"systemd-binfmt.service",
"systemd-bootchart.service",
"systemd-bus-proxyd.service",
"systemd-exit.service",
"systemd-fsck-root.service",
"systemd-fsck@.service",
"systemd-fsckd.service",
"systemd-halt.service",
"systemd-hibernate-resume@.service",
"systemd-hibernate.service",
"systemd-hostnamed.service",
"systemd-hwdb-update.service",
"systemd-hybrid-sleep.service",
"systemd-initctl.service",
"systemd-journal-flush.service",
"systemd-journald.service",
"systemd-kexec.service",
"systemd-localed.service",
"systemd-logind.service",
"systemd-machine-id-commit.service",
"systemd-modules-load.service",
"systemd-networkd-resolvconf-update.service",
"systemd-networkd-wait-online.service",
"systemd-networkd.service",
"systemd-poweroff.service",
"systemd-quotacheck.service",
"systemd-random-seed.service",
"systemd-reboot.service",
"systemd-remount-fs.service",
"systemd-resolved.service",
"systemd-rfkill.service",
"systemd-suspend.service",
"systemd-sysctl.service",
"systemd-timedated.service",
"systemd-timesyncd.service",
"systemd-tmpfiles-clean.service",
"systemd-tmpfiles-setup-dev.service",
"systemd-tmpfiles-setup.service",
"systemd-udev-settle.service",
"systemd-udev-trigger.service",
"systemd-udevd.service",
"systemd-update-utmp-runlevel.service",
"systemd-update-utmp.service",
"systemd-user-sessions.service",
"thermald.service",
"udev-configure-printer@.service",
"udev.service",
"udisks2.service",
"ufw.service",
"umountfs.service",
"umountnfs.service",
"umountroot.service",
"unattended-upgrades.service",
"upower.service",
"urandom.service",
"ureadahead-stop.service",
"ureadahead.service",
"usb_modeswitch@.service",
"usbmuxd.service",
"user@.service",
"uuidd.service",
"vgauth.service",
"wacom-inputattach@.service",
"whoopsie.service",
"wpa_supplicant.service",
"x11-common.service",
"-.slice",
"machine.slice",
"system.slice",
"user.slice",
"acpid.socket",
"apport-forward.socket",
"avahi-daemon.socket",
"cups.socket",
"dbus.socket",
"saned.socket",
"snapd.socket",
"syslog.socket",
"systemd-bus-proxyd.socket",
"systemd-fsckd.socket",
"systemd-initctl.socket",
"systemd-journald-audit.socket",
"systemd-journald-dev-log.socket",
"systemd-journald.socket",
"systemd-networkd.socket",
"systemd-rfkill.socket",
"systemd-udevd-control.socket",
"systemd-udevd-kernel.socket",
"uuidd.socket",
"basic.target",
"bluetooth.target",
"busnames.target",
"cryptsetup-pre.target",
"cryptsetup.target",
"ctrl-alt-del.target",
"default.target",
"emergency.target",
"exit.target",
"failsafe-graphical.target",
"final.target",
"getty.target",
"graphical.target",
"halt.target",
"hibernate.target",
"hybrid-sleep.target",
"initrd-fs.target",
"initrd-root-fs.target",
"initrd-switch-root.target",
"initrd.target",
"kexec.target",
"local-fs-pre.target",
"local-fs.target",
"mail-transport-agent.target",
"multi-user.target",
"network-online.target",
"network-pre.target",
"network.target",
"nss-lookup.target",
"nss-user-lookup.target",
"paths.target",
"poweroff.target",
"printer.target",
"reboot.target",
"remote-fs-pre.target",
"remote-fs.target",
"rescue.target",
"rpcbind.target",
"runlevel0.target",
"runlevel1.target",
"runlevel2.target",
"runlevel3.target",
"runlevel4.target",
"runlevel5.target",
"runlevel6.target",
"shutdown.target",
"sigpwr.target",
"sleep.target",
"slices.target",
"smartcard.target",
"sockets.target",
"sound.target",
"suspend.target",
"swap.target",
"sysinit.target",
"system-update.target",
"time-sync.target",
"timers.target",
"umount.target",
"apt-daily-upgrade.timer",
"apt-daily.timer",
"snapd.snap-repair.timer",
"systemd-tmpfiles-clean.timer",
"ureadahead-stop.timer"}
known_services_1 = {"acpid","alsa-restore","alsa-state","alsa-store","anacron","apport","console","dmesg","irqbalance","rc","thermald","tty1","tty2"
,"tty3","tty4","tty5","tty6","whoopsie","apparmor","bluetooth","avahi-daemon","brltty","console-setup","cups","cups-browsed",
"dbus","dns-clean","friendly-recovery","grub-common","kerneloops","killprocs","kmod","lightdm","networking","ondemand","pppd-dns",
"procps","pulseaudio","rc.local","resolvconf","rsync","rsyslog","saned","sendsigs","speech-dispatcher","sudo","udev","umountfs","umountfs.sh"
,"umountnfs.sh","umountroot","unattended-upgrades","urandom","x11-common"}

known_processes = {"COMMAND", "/lib/systemd/systemd", "[kthreadd]", "[kworker/0:0H]", "[mm_percpu_wq]", "[ksoftirqd/0]", "[rcu_sched]", "[rcu_bh]", "[migration/0]", "[watchdog/0]", "[cpuhp/0]", "[cpuhp/1]", "[watchdog/1]", "[migration/1]", "[ksoftirqd/1]", "[kworker/1:0H]", "[kdevtmpfs]", "[netns]", "[rcu_tasks_kthre]", "[kauditd]", "[khungtaskd]", "[oom_reaper]", "[writeback]", "[kcompactd0]", "[ksmd]", "[khugepaged]", "[crypto]", "[kintegrityd]", "[kblockd]", "[ata_sff]", "[md]", "[edac-poller]", "[devfreq_wq]", "[watchdogd]", "[kswapd0]", "[ecryptfs-kthrea]", "[kthrotld]", "[acpi_thermal_pm]", "[scsi_eh_0]", "[scsi_tmf_0]", "[scsi_eh_1]", "[scsi_tmf_1]", "[ipv6_addrconf]", "[kstrp]", "[charger_manager]", "[mpt_poll_0]", "[scsi_eh_2]", "[mpt/0]", "[scsi_tmf_2]", "[scsi_eh_3]", "[scsi_tmf_3]", "[scsi_eh_4]", "[scsi_tmf_4]", "[scsi_eh_5]", "[scsi_tmf_5]", "[scsi_eh_6]", "[scsi_tmf_6]", "[scsi_eh_7]", "[scsi_tmf_7]", "[scsi_eh_8]", "[scsi_tmf_8]", "[scsi_eh_9]", "[scsi_tmf_9]", "[scsi_eh_10]", "[scsi_tmf_10]", "[scsi_eh_11]", "[scsi_tmf_11]", "[scsi_eh_12]", "[scsi_tmf_12]", "[scsi_eh_13]", "[scsi_tmf_13]", "[scsi_eh_14]", "[scsi_tmf_14]", "[scsi_eh_15]", "[scsi_tmf_15]", "[scsi_eh_16]", "[scsi_tmf_16]", "[scsi_eh_17]", "[scsi_tmf_17]", "[scsi_eh_18]", "[scsi_tmf_18]", "[scsi_eh_19]", "[scsi_tmf_19]", "[scsi_eh_20]", "[scsi_tmf_20]", "[scsi_eh_21]", "[scsi_tmf_21]", "[scsi_eh_22]", "[scsi_tmf_22]", "[scsi_eh_23]", "[scsi_tmf_23]", "[scsi_eh_24]", "[scsi_tmf_24]", "[scsi_eh_25]", "[scsi_tmf_25]", "[scsi_eh_26]", "[scsi_tmf_26]", "[scsi_eh_27]", "[scsi_tmf_27]", "[scsi_eh_28]", "[scsi_tmf_28]", "[scsi_eh_29]", "[scsi_tmf_29]", "[scsi_eh_30]", "[scsi_tmf_30]", "[scsi_eh_31]", "[scsi_tmf_31]", "[scsi_eh_32]", "[scsi_tmf_32]", "[kworker/0:1H]", "[ttm_swap]", "[irq/16-vmwgfx]", "[kworker/1:1H]", "[jbd2/sda1-8]", "[ext4-rsv-conver]", "/lib/systemd/systemd-journald", "vmware-vmblock-fuse", "/usr/bin/vmtoolsd", "/usr/sbin/cupsd", "/usr/sbin/rsyslogd", "avahi-daemon:", "/usr/bin/VGAuthService", "/lib/systemd/systemd-logind", "avahi-daemon:", "/usr/sbin/cron", "/usr/sbin/acpid", "/usr/lib/accountsservice/accounts-daemon", "/usr/bin/dbus-daemon", "/usr/sbin/cups-browsed", "/usr/sbin/NetworkManager", "/usr/lib/bluetooth/bluetoothd", "/sbin/agetty", "/usr/sbin/lightdm", "/usr/sbin/irqbalance", "/usr/lib/xorg/Xorg", "/usr/sbin/dnsmasq", "lightdm", "/usr/bin/vmhgfs-fuse", "/usr/lib/rtkit/rtkit-daemon", "[krfcommd]", "/usr/lib/upower/upowerd", "/usr/lib/colord/colord", "/usr/bin/whoopsie", "/lib/systemd/systemd",
                       "(sd-pam)", "/usr/bin/gnome-keyring-daemon", "/sbin/upstart", "upstart-udev-bridge", "dbus-daemon", "/usr/lib/x86_64-linux-gnu/hud/window-stack-bridge", "upstart-dbus-bridge", "upstart-file-bridge", "upstart-dbus-bridge", "/usr/bin/ibus-daemon", "/usr/lib/gvfs/gvfsd", "/usr/lib/at-spi2-core/at-spi-bus-launcher", "/usr/bin/dbus-daemon", "/usr/lib/gvfs/gvfsd-fuse", "/usr/lib/at-spi2-core/at-spi2-registryd", "/usr/lib/ibus/ibus-dconf", "/usr/lib/ibus/ibus-ui-gtk3", "/usr/lib/ibus/ibus-x11", "/usr/lib/ibus/ibus-engine-simple", "gpg-agent", "/usr/lib/x86_64-linux-gnu/hud/hud-service", "/usr/lib/unity-settings-daemon/unity-settings-daemon", "/usr/lib/gnome-session/gnome-session-binary", "/usr/lib/x86_64-linux-gnu/unity/unity-panel-service", "/usr/lib/x86_64-linux-gnu/indicator-messages/indicator-messages-service", "/usr/lib/x86_64-linux-gnu/indicator-bluetooth/indicator-bluetooth-service", "/usr/lib/x86_64-linux-gnu/indicator-power/indicator-power-service", "/usr/lib/x86_64-linux-gnu/indicator-datetime/indicator-datetime-service", "/usr/lib/x86_64-linux-gnu/indicator-keyboard/indicator-keyboard-service", "/usr/lib/x86_64-linux-gnu/indicator-sound/indicator-sound-service", "/usr/lib/x86_64-linux-gnu/indicator-printers/indicator-printers-service", "/usr/lib/x86_64-linux-gnu/indicator-session/indicator-session-service", "/usr/lib/x86_64-linux-gnu/indicator-application/indicator-application-service", "/usr/lib/evolution/evolution-source-registry", "/usr/bin/pulseaudio", "/usr/lib/dconf/dconf-service", "compiz", "/usr/lib/evolution/evolution-calendar-factory", "/usr/lib/unity-settings-daemon/unity-fallback-mount-helper", "/usr/bin/gnome-software", "/usr/bin/vmtoolsd", "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1", "nm-applet", "nautilus", "/usr/lib/gvfs/gvfs-udisks2-volume-monitor", "/usr/lib/udisks2/udisksd", "/usr/lib/gvfs/gvfs-gphoto2-volume-monitor", "/usr/lib/gvfs/gvfs-goa-volume-monitor", "/usr/lib/gvfs/gvfs-mtp-volume-monitor", "/usr/lib/gvfs/gvfs-afc-volume-monitor", "/usr/lib/evolution/evolution-calendar-factory-subprocess", "/usr/lib/evolution/evolution-addressbook-factory", "/usr/lib/evolution/evolution-calendar-factory-subprocess", "/usr/lib/evolution/evolution-addressbook-factory-subprocess", "/usr/lib/gvfs/gvfsd-trash", "/usr/lib/gvfs/gvfsd-metadata", "/usr/lib/gnome-terminal/gnome-terminal-server", "zeitgeist-datahub", "/usr/bin/zeitgeist-daemon", "/usr/lib/x86_64-linux-gnu/zeitgeist-fts", "update-notifier", "/usr/lib/x86_64-linux-gnu/deja-dup/deja-dup-monitor", "/usr/lib/x86_64-linux-gnu/notify-osd", "[xfsalloc]", "[xfs_mru_cache]", "[jfsIO]", "[jfsCommit]", "[jfsCommit]", "[jfsSync]", "/usr/lib/x86_64-linux-gnu/unity-scope-home/unity-scope-home", "/usr/bin/unity-scope-loader", "/usr/lib/x86_64-linux-gnu/unity-lens-files/unity-files-daemon", "/usr/lib/libunity-webapps/unity-webapps-service", "/usr/lib/x86_64-linux-gnu/bamf/bamfdaemon", "/usr/lib/policykit-1/polkitd", "/usr/lib/gvfs/gvfsd-http", "/usr/lib/gvfs/gvfsd-network", "/usr/lib/gvfs/gvfsd-dnssd", "/lib/systemd/systemd-networkd", "/lib/systemd/systemd-timesyncd", "/lib/systemd/systemd-udevd", "bash", "[kworker/u257:0]", "[kworker/u257:1]", "/sbin/dhclient", "[kworker/1:1]", "[kworker/0:1]", "[kworker/u256:1]", "[kworker/u256:2]", "[kworker/0:2]", "[kworker/1:0]", "[kworker/u256:0]", "ps",
                       "/sbin/getty","/sbin/init","NetworkManager","/usr/sbin/ModemManager","gnome-pty-helper","/usr/lib/unity/unity-panel-service","rsyslogd","/sbin/getty","/usr/lib/x86_64-linux-gnu/gconf/gconfd-2","/usr/lib/x86_64-linux-gnu/indicator-keyboard-service","/usr/lib/gvfsd-burn","gnome-session","telepathy-indicator","upstart-socket-bridge","acpid","/lib/systemd/systemd-hostnamed","whoopsie","/usr/sbin/kerneloops","upstart-event-bridge","/bin/dbus-daemon","/usr/lib/x86_64-linux-gnu/unity-lens-music/unity-music-daemon","/usr/lib/telepathy/mission-control-5",
                       "/usr/lib/gvfs/gvfsd-burn","/usr/sbin/bluetoothd","/bin/cat","gnome-terminal","/usr/lib/NetworkManager/nm-dispatcher.action","init","/usr/lib/cups/notifier/dbus","/usr/lib/snapd/snapd","/usr/lib/x86_64-linux-gnu/fwupd/fwupd","/usr/lib/i386-linux-gnu/bamf/bamfdaemon", "/usr/lib/i386-linux-gnu/indicator-power/indicator","/usr/lib/i386-linux-gnu/hud/hud-service","/usr/lib/i386-linux-gnu/deja-dup/deja-dup-monitor","/usr/lib/i386-linux-gnu/gconf/gconfd-2","/usr/lib/i386-linux-gnu/indicator-sound/indicator","/usr/lib/i386-linux-gnu/hud/window-stack-bridge","/usr/lib/i386-linux-gnu/notify-osd","/usr/lib/i386-linux-gnu/zeitgeist-fts","/usr/lib/i386-linux-gnu/indicator-power/indicator","/usr/lib/i386-linux-gnu/gconf/gconfd-2","deja-dup --prompt","/usr/lib/i386-linux-gnu/hud/window-stack-bridge","/usr/lib/i386-linux-gnu/deja-dup/deja-dup-monitor","/usr/lib/i386-linux-gnu/indicator-bluetooth/indicator"}

def getFullPath(pid):
    return os.path.realpath("/proc/"+str(pid)+"/exe")


def getPids(proc):
    proc = proc.strip()
    pids = []
    for dirname in os.listdir('/proc'):
        if dirname == 'curproc':
            continue
        if not dirname.isdigit():
            continue
        filename = "/proc/"+dirname+"/cmdline"
        with open(filename) as file:
            content = " ".join(file.read().decode().split('\x00'))
            if proc in content.strip():
                pids.append(int(dirname))
    return pids


def findSuspProc():
    MAX_COMMAND_LEN = 50
    MAX_PID_LEN = 7
    
    print("Scanning for suspicious processes...")
    ps = subprocess.check_output(('ps', '-axo', 'command'))
    lines = ps.split("\n")
    suspCommands = set()
    for line in lines:
        line = line.strip()
        if len(line) < 1:
            continue
        command = line.split(" ")[0]
        if command not in known_processes:
            suspCommands.add(line)
    for command in suspCommands:
        pids = getPids(command)
        for pid in pids:
            commandStr = ("\""+command+"\"")[0:MAX_COMMAND_LEN].ljust(MAX_COMMAND_LEN, " ")
            print(("Potentially suspicious: %s\t| PID: %"+str(MAX_PID_LEN) +"i\t| PATH: %s")
                 % (commandStr, pid, getFullPath(pid)))

def isProgramInstalled(name):
    try:
        ps = subprocess.check_output(["which",name])
    except subprocess.CalledProcessError:
        return False
    return len(ps) > 1

def getServices():
    print("Scanning for suspicious services...")
    if isProgramInstalled("systemctl"):
        ps = subprocess.check_output(['systemctl','list-unit-files'])
        #Todo systemctl --user list-unit-files
        lines = ps.split("\n")[1:-2]
        for line in lines:
            line = line.strip()
            if len(line) < 1:
                continue
            line = re.sub(" +"," ",line)
            splitLine = line.split(" ")
            if splitLine[0] not in known_services:
                    test2 = splitLine[0]
                    if ".target" in splitLine[0]:
                        test2 = splitLine[0].replace(".target",".service")
                    elif ".service" in splitLine[0]:
                        test2 = splitLine[0].replace(".service",".target")
                    if test2 in known_services:
                        continue
                    print("Potentially suspicious service: " + line)
    elif isProgramInstalled("service"):
        cmd = "grep -i 'runlevel' /etc/init/* | awk '/start on/ && /2/ {gsub(\"/\",\" \"); gsub(\":\", \" \");gsub(\".conf\",\" \"); print $3  }'"
        services = subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT).communicate()[0]
        for service in services.split("\n"):
            if len(service.strip()) < 1:
                continue
            if service not in known_services_1:
                print("Potentially suspicious service: " + service)
        cmd = "service --status-all"
        services = subprocess.Popen(cmd,shell=True,stdout=subprocess.PIPE,stderr=subprocess.STDOUT).communicate()[0]
        services = services.split("\n")
        for service in services:
            if len(service.split("] ")) < 2:
                continue
            service = service.split("] ")[1].strip()
            if service not in known_services_1:
                print("Potentially suspicious service: " + service)

        

def findSuspServices():
    getServices()
    pass

findSuspProc()
print("\n")
findSuspServices()