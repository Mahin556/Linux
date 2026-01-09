* https://freedium-mirror.cfd/https://medium.com/@sebastiancarlos/systemds-nuts-and-bolts-0ae7995e45d3
* https://www.digitalocean.com/community/tutorials/understanding-systemd-units-and-unit-files
* https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs
* https://www.digitalocean.com/community/tutorials/how-to-use-systemctl-to-manage-systemd-services-and-units
* https://www.digitalocean.com/community/tutorials/systemd-essentials-working-with-services-units-and-the-journal
* https://serverfault.com/questions/840996/modify-systemd-unit-file-without-altering-upstream-unit-file
* https://docs.redhat.com/en/documentation/red_hat_enterprise_linux/9/html/using_systemd_unit_files_to_customize_and_optimize_your_system/assembly_working-with-systemd-unit-files_working-with-systemd
* https://askubuntu.com/questions/659267/how-do-i-override-or-configure-systemd-services
* 
---

```bash
systemctl list-unit-files --type=service | grep docker.service
```