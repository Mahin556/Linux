Here's a reference for common `lspci` commands:

## Basic Usage

```bash
lspci                        # List all PCI devices
lspci -v                     # Verbose output
lspci -vv                    # Very verbose output
lspci -vvv                   # Maximum verbosity
```

## Filtering & Search

```bash
lspci | grep -i nvidia       # Find NVIDIA devices
lspci | grep -i vga          # Find graphics cards
lspci | grep -i usb          # Find USB controllers
lspci | grep -i network      # Find network cards
lspci | grep -i audio        # Find audio devices
lspci | grep -i sata         # Find SATA controllers
```

## Display Formats

```bash
lspci -nn                    # Show vendor/device ID codes [xxxx:xxxx]
lspci -n                     # Show only numeric IDs (no names)
lspci -t                     # Show as a tree
lspci -tv                    # Tree view with details
lspci -mm                    # Machine-readable output
lspci -vmm                   # Verbose machine-readable output
```

## Kernel Driver Info

```bash
lspci -k                     # Show kernel driver in use + available modules
lspci -v -s 00:02.0          # Detailed info for a specific device by slot
```

## Specific Device by ID or Slot

```bash
lspci -s 00:1f.0             # Show device at slot 00:1f.0
lspci -s 00:1f.0 -v          # Verbose info for that slot
lspci -d 10de:               # Filter by vendor ID (NVIDIA = 10de)
lspci -d 8086:               # Filter by vendor ID (Intel = 8086)
lspci -d 1002:               # Filter by vendor ID (AMD = 1002)
```

## Update PCI ID Database

```bash
sudo update-pciids            # Refresh /usr/share/misc/pci.ids
lspci -Q                     # Query central database for unknown IDs (needs internet)
```

## Combining Options (Common Combos)

```bash
lspci -nnk                   # IDs + kernel drivers — great for troubleshooting
lspci -vnn | grep -i vga     # VGA card with vendor/device IDs
lspci -tv | less             # Scrollable tree view
lspci -k | grep -A 3 "VGA"  # GPU + 3 lines of driver info
```

---

**Tip:** Slot addresses follow the format `[domain:]bus:device.function` — e.g., `0000:00:02.0`. You can copy the slot from plain `lspci` output and pass it to `-s` for a deep dive on any device.