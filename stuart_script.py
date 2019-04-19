#!/usr/bin/python
import subprocess
import re
import os


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

    known_processes = {"COMMAND", "/lib/systemd/systemd", "[kthreadd]", "[kworker/0:0H]", "[mm_percpu_wq]", "[ksoftirqd/0]", "[rcu_sched]", "[rcu_bh]", "[migration/0]", "[watchdog/0]", "[cpuhp/0]", "[cpuhp/1]", "[watchdog/1]", "[migration/1]", "[ksoftirqd/1]", "[kworker/1:0H]", "[kdevtmpfs]", "[netns]", "[rcu_tasks_kthre]", "[kauditd]", "[khungtaskd]", "[oom_reaper]", "[writeback]", "[kcompactd0]", "[ksmd]", "[khugepaged]", "[crypto]", "[kintegrityd]", "[kblockd]", "[ata_sff]", "[md]", "[edac-poller]", "[devfreq_wq]", "[watchdogd]", "[kswapd0]", "[ecryptfs-kthrea]", "[kthrotld]", "[acpi_thermal_pm]", "[scsi_eh_0]", "[scsi_tmf_0]", "[scsi_eh_1]", "[scsi_tmf_1]", "[ipv6_addrconf]", "[kstrp]", "[charger_manager]", "[mpt_poll_0]", "[scsi_eh_2]", "[mpt/0]", "[scsi_tmf_2]", "[scsi_eh_3]", "[scsi_tmf_3]", "[scsi_eh_4]", "[scsi_tmf_4]", "[scsi_eh_5]", "[scsi_tmf_5]", "[scsi_eh_6]", "[scsi_tmf_6]", "[scsi_eh_7]", "[scsi_tmf_7]", "[scsi_eh_8]", "[scsi_tmf_8]", "[scsi_eh_9]", "[scsi_tmf_9]", "[scsi_eh_10]", "[scsi_tmf_10]", "[scsi_eh_11]", "[scsi_tmf_11]", "[scsi_eh_12]", "[scsi_tmf_12]", "[scsi_eh_13]", "[scsi_tmf_13]", "[scsi_eh_14]", "[scsi_tmf_14]", "[scsi_eh_15]", "[scsi_tmf_15]", "[scsi_eh_16]", "[scsi_tmf_16]", "[scsi_eh_17]", "[scsi_tmf_17]", "[scsi_eh_18]", "[scsi_tmf_18]", "[scsi_eh_19]", "[scsi_tmf_19]", "[scsi_eh_20]", "[scsi_tmf_20]", "[scsi_eh_21]", "[scsi_tmf_21]", "[scsi_eh_22]", "[scsi_tmf_22]", "[scsi_eh_23]", "[scsi_tmf_23]", "[scsi_eh_24]", "[scsi_tmf_24]", "[scsi_eh_25]", "[scsi_tmf_25]", "[scsi_eh_26]", "[scsi_tmf_26]", "[scsi_eh_27]", "[scsi_tmf_27]", "[scsi_eh_28]", "[scsi_tmf_28]", "[scsi_eh_29]", "[scsi_tmf_29]", "[scsi_eh_30]", "[scsi_tmf_30]", "[scsi_eh_31]", "[scsi_tmf_31]", "[scsi_eh_32]", "[scsi_tmf_32]", "[kworker/0:1H]", "[ttm_swap]", "[irq/16-vmwgfx]", "[kworker/1:1H]", "[jbd2/sda1-8]", "[ext4-rsv-conver]", "/lib/systemd/systemd-journald", "vmware-vmblock-fuse", "/usr/bin/vmtoolsd", "/usr/sbin/cupsd", "/usr/sbin/rsyslogd", "avahi-daemon:", "/usr/bin/VGAuthService", "/lib/systemd/systemd-logind", "avahi-daemon:", "/usr/sbin/cron", "/usr/sbin/acpid", "/usr/lib/accountsservice/accounts-daemon", "/usr/bin/dbus-daemon", "/usr/sbin/cups-browsed", "/usr/sbin/NetworkManager", "/usr/lib/bluetooth/bluetoothd", "/sbin/agetty", "/usr/sbin/lightdm", "/usr/sbin/irqbalance", "/usr/lib/xorg/Xorg", "/usr/sbin/dnsmasq", "lightdm", "/usr/bin/vmhgfs-fuse", "/usr/lib/rtkit/rtkit-daemon", "[krfcommd]", "/usr/lib/upower/upowerd", "/usr/lib/colord/colord", "/usr/bin/whoopsie", "/lib/systemd/systemd",
                       "(sd-pam)", "/usr/bin/gnome-keyring-daemon", "/sbin/upstart", "upstart-udev-bridge", "dbus-daemon", "/usr/lib/x86_64-linux-gnu/hud/window-stack-bridge", "upstart-dbus-bridge", "upstart-file-bridge", "upstart-dbus-bridge", "/usr/bin/ibus-daemon", "/usr/lib/gvfs/gvfsd", "/usr/lib/at-spi2-core/at-spi-bus-launcher", "/usr/bin/dbus-daemon", "/usr/lib/gvfs/gvfsd-fuse", "/usr/lib/at-spi2-core/at-spi2-registryd", "/usr/lib/ibus/ibus-dconf", "/usr/lib/ibus/ibus-ui-gtk3", "/usr/lib/ibus/ibus-x11", "/usr/lib/ibus/ibus-engine-simple", "gpg-agent", "/usr/lib/x86_64-linux-gnu/hud/hud-service", "/usr/lib/unity-settings-daemon/unity-settings-daemon", "/usr/lib/gnome-session/gnome-session-binary", "/usr/lib/x86_64-linux-gnu/unity/unity-panel-service", "/usr/lib/x86_64-linux-gnu/indicator-messages/indicator-messages-service", "/usr/lib/x86_64-linux-gnu/indicator-bluetooth/indicator-bluetooth-service", "/usr/lib/x86_64-linux-gnu/indicator-power/indicator-power-service", "/usr/lib/x86_64-linux-gnu/indicator-datetime/indicator-datetime-service", "/usr/lib/x86_64-linux-gnu/indicator-keyboard/indicator-keyboard-service", "/usr/lib/x86_64-linux-gnu/indicator-sound/indicator-sound-service", "/usr/lib/x86_64-linux-gnu/indicator-printers/indicator-printers-service", "/usr/lib/x86_64-linux-gnu/indicator-session/indicator-session-service", "/usr/lib/x86_64-linux-gnu/indicator-application/indicator-application-service", "/usr/lib/evolution/evolution-source-registry", "/usr/bin/pulseaudio", "/usr/lib/dconf/dconf-service", "compiz", "/usr/lib/evolution/evolution-calendar-factory", "/usr/lib/unity-settings-daemon/unity-fallback-mount-helper", "/usr/bin/gnome-software", "/usr/bin/vmtoolsd", "/usr/lib/policykit-1-gnome/polkit-gnome-authentication-agent-1", "nm-applet", "nautilus", "/usr/lib/gvfs/gvfs-udisks2-volume-monitor", "/usr/lib/udisks2/udisksd", "/usr/lib/gvfs/gvfs-gphoto2-volume-monitor", "/usr/lib/gvfs/gvfs-goa-volume-monitor", "/usr/lib/gvfs/gvfs-mtp-volume-monitor", "/usr/lib/gvfs/gvfs-afc-volume-monitor", "/usr/lib/evolution/evolution-calendar-factory-subprocess", "/usr/lib/evolution/evolution-addressbook-factory", "/usr/lib/evolution/evolution-calendar-factory-subprocess", "/usr/lib/evolution/evolution-addressbook-factory-subprocess", "/usr/lib/gvfs/gvfsd-trash", "/usr/lib/gvfs/gvfsd-metadata", "/usr/lib/gnome-terminal/gnome-terminal-server", "zeitgeist-datahub", "/usr/bin/zeitgeist-daemon", "/usr/lib/x86_64-linux-gnu/zeitgeist-fts", "update-notifier", "/usr/lib/x86_64-linux-gnu/deja-dup/deja-dup-monitor", "/usr/lib/x86_64-linux-gnu/notify-osd", "[xfsalloc]", "[xfs_mru_cache]", "[jfsIO]", "[jfsCommit]", "[jfsCommit]", "[jfsSync]", "/usr/lib/x86_64-linux-gnu/unity-scope-home/unity-scope-home", "/usr/bin/unity-scope-loader", "/usr/lib/x86_64-linux-gnu/unity-lens-files/unity-files-daemon", "/usr/lib/libunity-webapps/unity-webapps-service", "/usr/lib/x86_64-linux-gnu/bamf/bamfdaemon", "/usr/lib/policykit-1/polkitd", "/usr/lib/gvfs/gvfsd-http", "/usr/lib/gvfs/gvfsd-network", "/usr/lib/gvfs/gvfsd-dnssd", "/lib/systemd/systemd-networkd", "/lib/systemd/systemd-timesyncd", "/lib/systemd/systemd-udevd", "bash", "[kworker/u257:0]", "[kworker/u257:1]", "/sbin/dhclient", "[kworker/1:1]", "[kworker/0:1]", "[kworker/u256:1]", "[kworker/u256:2]", "[kworker/0:2]", "[kworker/1:0]", "[kworker/u256:0]", "ps"}
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
    if isProgramInstalled("systemctl"):
        ps = subprocess.check_output(['systemctl','list-unit-files'])
        
def findSuspServices():
    if isProgramInstalled("systemctl"):
        print("systemctl")
        
    elif isProgramInstalled("service"):
        print("service")
    pass

findSuspProc()
findSuspServices()
#import code
# code.interact(local=locals())
