#!/bin/bash
# Validates semantics labels for inventory and spell controls
# Run: ./tools/validate_semantics.sh

TARGET_FILE="lib/src/features/characters/presentation/character_sheet_screen.dart"

echo ""
echo "=============================================================="
echo "SEMANTICS LABEL VALIDATION REPORT"
echo "=============================================================="
echo ""

# Define valid labels
VALID_LABELS="decrease quantity
increase quantity
spend 1
toggle equipped
toggle carried
clear charges
track charges
decrease charges
increase charges
split stack
transfer to container
merge with containers
select container"

ERRORS=0
WARNINGS=0

echo "Checking Semantics labels in $TARGET_FILE..."
echo ""

# Extract all Semantics labels from the file
echo "Found Semantics widgets:"
grep -n "Semantics(" "$TARGET_FILE" | while read -r line; do
    line_num=$(echo "$line" | cut -d: -f1)
    line_content=$(echo "$line" | cut -d: -f2-)
    
    # Extract label
    label=$(echo "$line_content" | grep -oP "label:\s*'\K[^']+" || echo "N/A")
    widget=$(echo "$line_content" | grep -oP "IconButton|ActionChip|FilterChip|DropdownButton" | head -1 || echo "unknown")
    
    # Check if label is valid
    is_valid=0
    if echo "$VALID_LABELS" | grep -qx "$label"; then
        is_valid=1
    fi
    
    if [ $is_valid -eq 0 ]; then
        if [ "$label" = "N/A" ]; then
            echo "  Line $line_num: No label found"
        else
            echo "  Line $line_num: INVALID - '$label' (widget: $widget)"
            ERRORS=$((ERRORS+1))
        fi
    else
        echo "  Line $line_num: OK - '$label' (widget: $widget)"
    fi
done

echo ""
echo "=============================================================="
echo "Summary: $ERRORS errors found"
echo "=============================================================="

if [ $ERRORS -gt 0 ]; then
    exit 1
fi
