#!/bin/csh
# gather the sub-plots into one summary plot
#
# Requires: ghostscript and psutils. 

set TMP1 = `mktemp /tmp/sheba_tmp1XXXXXX` && mv "$TMP1" "$TMP1.ps" && set TMP1 = "$TMP1.ps"
set TMP2 = `mktemp /tmp/sheba_tmp2XXXXXX` && mv "$TMP2" "$TMP2.ps" && set TMP2 = "$TMP2.ps"
set TMP3 = `mktemp /tmp/sheba_tmp3XXXXXX` && mv "$TMP3" "$TMP3.ps" && set TMP3 = "$TMP3.ps"

# undo the rotation of the error plots
pstops -q -pa4 '1:0L' $1_errclu.eps "$TMP1"

# combine the plot files
gs -q -dNOPAUSE -sDEVICE=ps2write -sOUTPUTFILE="$TMP2" -dBATCH split_inp.ps split_rot.ps split_wav.ps "$TMP1"

# make them into a single page
pstops -q -pa4 '4:0@0.49(0,0)+1@0.49(0,0.4h)+2@0.5(0.42w,0)+3@0.40(0.5w,0.45h)' "$TMP2" "$TMP3"

# copy this file
\cp "$TMP3" $1_result.ps

# tidy up
rm -f "$TMP1" "$TMP2" "$TMP3"
