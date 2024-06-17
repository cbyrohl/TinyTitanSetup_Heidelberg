#!/bin/bash
#
set -e

# Define paths
ORIGINAL_ISO=$TINYTITAN_ISOPATH
WORKING_DIR=$PWD
NEW_ISO="xubuntu_autoinstall.iso"
AUTOINSTALL_FILE="autoinstall.yaml"
AUTOINSTALL_DESTINATION="/"  # Adjust according to ISO structure
MOUNT_DIR="$WORKING_DIR/original_iso"
EXTRACT_DIR="$WORKING_DIR/extracted_iso"
#MOD_DIR="$WORKING_DIR/new_iso"

if [[ -z "$ORIGINAL_ISO" ]]; then
    echo "Error: Need the path to the iso image download."
    exit 1
fi


# Ensure the necessary tools are installed
# sudo apt-get update
# sudo apt-get install -y genisoimage xorriso
# sudo apt-get install syslinux syslinux-common

# Create working directories
mkdir -p "$EXTRACT_DIR"

## Extract the original ISO including boot parameters
#echo "Extracting ISO..."
#xorriso -osirrox on -indev "$ORIGINAL_ISO" -extract / "$EXTRACT_DIR"
#echo "Extraction complete."
#
## Add the autoinstall file to the extracted directory
#mkdir -p "$EXTRACT_DIR/$AUTOINSTALL_DESTINATION"  # Ensure destination directory exists
#cp "$AUTOINSTALL_FILE" "$EXTRACT_DIR/$AUTOINSTALL_DESTINATION"
#echo "File added to ISO directory."

xorriso -indev $ORIGINAL_ISO -outdev $NEW_ISO -add $AUTOINSTALL_FILE -- -boot_image any replay

## Recreate the ISO preserving GRUB boot details
#xorriso -as mkisofs \
#  -iso-level 3 \
#  -full-iso9660-filenames \
#  -volid "Modified_ISO" \
#  -output "$NEW_ISO" \
#  -graft-points \
#  "$EXTRACT_DIR/" \
#  -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin \
#  -boot-load-size 4 \
#  -no-emul-boot \
#  -boot-info-table \
#  -eltorito-boot boot/grub/i386-pc/eltorito.img \
#  -eltorito-catalog boot/grub/x86_64-efi/bootx64.efi \
#  -isohybrid-gpt-basdat

#xorriso -as mkisofs \
#  -iso-level 3 \
#  -full-iso9660-filenames \
#  -volid "Modified_ISO" \
#  -output "$NEW_ISO" \
#  -graft-points \
#  "$EXTRACT_DIR/" \
#  -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin \
#  -isohybrid-gpt-basdat \
#  -boot-load-size 4 \
#  -no-emul-boot \
#  -boot-info-table

#xorriso -as mkisofs \
#    -verbose \
#    -iso-level 3 \
#    -full-iso9660-filenames \
#    -volid "Modified_ISO" \
#    -output "$NEW_ISO" \
#    -graft-points \
#    "$EXTRACT_DIR/" \
#    -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin \
#    -isohybrid-gpt-basdat


echo "New ISO created at $NEW_ISO."

# Clean up (optional)
#echo "Cleaning up..."
#chown -R $USER:$USER "$EXTRACT_DIR"
#chmod -R u+w "$EXTRACT_DIR"
#rm -rf "$EXTRACT_DIR"

echo "Clean up complete."

#
## Create working directories
#mkdir -p "$MOUNT_DIR"
#mkdir -p "$MOD_DIR"
#
## Mount the original ISO
#sudo mount -o loop "$ORIGINAL_ISO" "$MOUNT_DIR"
#
## Copy the contents of the original ISO to a new directory
#cp -rT "$MOUNT_DIR" "$MOD_DIR"
#
## Unmount the original ISO
#sudo umount "$MOUNT_DIR"
#
## Add the autoinstall file to the modified directory
#mkdir -p "$MOD_DIR/$AUTOINSTALL_DESTINATION"  # Ensure destination directory exists
#cp "$AUTOINSTALL_FILE" "$MOD_DIR/$AUTOINSTALL_DESTINATION"
#
## Create a new ISO image
#cd "$MOD_DIR"
#xorriso -as mkisofs -r -J -V "Modified ISO" -o "$WORKING_DIR/$NEW_ISO" .
#
## Clean up
#cd ..
#rm -r "$MOUNT_DIR"
#sudo rm -rf "$MOD_DIR"

# Verify
# mkdir "$MOUNT_DIR"
# sudo mount -o loop "$NEW_ISO" "$MOUNT_DIR"
# ls -l "$MOUNT_DIR/$AUTOINSTALL_DESTINATION"
# sudo umount "$MOUNT_DIR"

echo "ISO modification complete. New ISO is at $NEW_ISO"
