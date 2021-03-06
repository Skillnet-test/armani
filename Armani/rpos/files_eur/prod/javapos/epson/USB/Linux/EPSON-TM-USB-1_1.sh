#! /bin/sh
# This garbage is normal
skip=169
# This script was generated using Makeself 1.5.3
CRCsum=284646894
MD5=00000000000000000000000000000000
label="Linux USB Driver for TM series"
script=./install.sh
targetdir=release
scriptargs=""
keep=n
finish=true; xterm_loop=;
[ x"$1" = x-xwin ] && {
 finish="echo Press Return to close this window...; read junk"; xterm_loop=1; shift 1;
}
if [ x"$1" = "x-help" -o x"$1" = "x--help" ]; then
  cat << tac
 1) Getting help or info about $0 :
  $0 -help   Print this message
  $0 -info   Print embedded info : title, default target directory, embedded script ...
  $0 -lsm    Print embedded lsm entry (or no LSM)
  $0 -list   Print the list of files in the archive
  $0 -check  Checks integrity of the archive
 
 2) Running $0 :
  $0 [options] [additional arguments to embedded script]
  with following options (in that order)
  -confirm             Ask before running embedded script
  -keep                Do not erase target directory after running embedded script
  -target NewDirectory Extract in NewDirectory
tac
  exit 0;
fi
if [ x"$1" = "x-lsm" -o x"$1" = "x--lsm" ]; then
  cat << EOF_LSM
no LSM
EOF_LSM
  exit 0;
fi
if [ "$1" = "-info" ]; then
	echo Identification: $label
	echo Target directory: $targetdir
	echo Uncompressed size: 232 KB
	echo Compression: gzip
	echo Date of packaging: Fri Mar  8 15:58:29 EST 2002
	echo script run after extraction: $script $scriptargs
	[ x"$keep" = xy ] && echo "directory $targetdir is permanent" || echo "$targetdir will be removed after extraction"
	exit 0;
fi
if [ "$1" = "-list" ]; then
	echo Target directory: $targetdir
	tail +$skip $0  | gzip -cd | tar tvf -
	exit 0;
fi
if [ "$1" = "-check" ]; then
sum1=`tail +6 $0 | cksum | sed -e 's/ /Z/' -e 's/	/Z/' | cut -dZ -f1`
[ $sum1 -ne $CRCsum ] && {
  echo Error in checksums $sum1 $CRCsum
  exit 2;
}
if [ $MD5 != "00000000000000000000000000000000" ]; then
# space separated list of directories
  [ x"$GUESS_MD5_PATH" = "x" ] && GUESS_MD5_PATH="/usr/local/ssl/bin"
  MD5_PATH=""
  for a in $GUESS_MD5_PATH; do
    if which $a/md5 >/dev/null 2>&1 ; then
       MD5_PATH=$a;
    fi
  done
  if [ -x $MD5_PATH/md5 ]; then
    md5sum=`tail +6 $0 | $MD5_PATH/md5`;
    [ $md5sum != $MD5 ] && {
      echo Error in md5 sums $md5sum $MD5
      exit 2;
    } || { echo check sums and md5 sums are ok; exit 0; }
  fi
  if [ ! -x $MD5_PATH/md5 ]; then
      echo an embedded md5 sum of the archive exists but no md5 program was found in $GUESS_MD5_PATH
      echo if you have md5 on your system, you should try :
      echo env GUESS_MD5_PATH=\"FirstDirectory SecondDirectory ...\" $0 -check
  fi
else
  echo check sums are OK ; echo $0 does not contain embedded md5 sum ;
fi
	exit 0;
fi
if ! tty -s; then                 # Do we have a terminal?
    if [ x"$DISPLAY" != x -a x"$xterm_loop" = x ]; then  # No, but do we have X?
		if xset q > /dev/null 2>&1; then # Check for valid DISPLAY variable
			GUESS_XTERMS="dtterm eterm Eterm xterm rxvt kvt"
			for a in $GUESS_XTERMS; do
				if which $a >/dev/null 2>&1; then
					XTERM=$a
					break
				fi
			done
			chmod a+x $0 || echo Please add execution rights on $0
			if [ `echo "$0" | cut -c1` = / ]; then # Spawn a terminal!
				exec $XTERM -title "$label" -e "$0" -xwin "$@"
			else
				exec $XTERM -title "$label" -e "./$0" -xwin "$@"
			fi
		fi
    fi
fi
[ x"$finish" = x ] && finish=true
parsing=yes
while [ x"$parsing" != x ]; do
    case "$1" in
      -confirm) verbose=y; shift;;
      -keep) keep=y; shift;;
      -target) if [ x"$2" != x ]; then targetdir="$2"; keep=y; shift 2; fi;;
      *) parsing="";;
    esac
done
if [ "$keep" = y ]; then echo "Creating directory $targetdir"; tmpdir=$targetdir;
else tmpdir="/tmp/selfgz$$"; fi
location=`pwd`
echo=echo; [ -x /usr/ucb/echo ] && echo=/usr/ucb/echo
mkdir $tmpdir || {
        $echo 'Cannot create target directory' $tmpdir >&2
        $echo 'you should perhaps try option -target OtherDirectory' >&2
		eval $finish; exit 1;
}
$echo -n Verifying archive integrity...
sum1=`tail +6 $0 | cksum | sed -e 's/ /Z/' -e 's/	/Z/' | cut -dZ -f1`
[ $sum1 -ne $CRCsum ] && {
  $echo Error in check sums $sum1 $CRCsum
  eval $finish; exit 2;
}
echo OK
if [ $MD5 != \"00000000000000000000000000000000\" ]; then
# space separated list of directories
  [ x$GUESS_MD5_PATH = x ] && GUESS_MD5_PATH=\"/usr/local/ssl/bin\"
  MD5_PATH=\"\"
  for a in $GUESS_MD5_PATH; do
    if which $a/md5 >/dev/null 2>&1 ; then
       MD5_PATH=$a;
    fi
  done
  if [ -x $MD5_PATH/md5 ]; then
    md5sum=`tail +6 $0 | $MD5_PATH/md5`;
    [ $md5sum != $MD5 ] && {
      $echo Error in md5 sums $md5sum $MD5
      eval $finish; exit 2;
    }
  fi
fi
$echo -n "Uncompressing $label"
cd $tmpdir
[ "$keep" = y ] || trap 'cd /tmp; /bin/rm -rf $tmpdir; exit $res'
if ( (cd $location; tail +$skip $0; ) | gzip -cd | tar xvof - |  (while read a; do $echo -n .; done; echo; )) 2> /dev/null; then
    res=0; if [ x"$script" != x ]; then
		if [ x"$verbose" = xy ]; then
			$echo "OK to execute: $script $scriptargs $* ? [Y/n] "
			read yn
			[ x"$yn" = x -o x"$yn" = xy -o x"$yn" = xY ] && { $script $scriptargs $*; res=$?; }
		else
			$script $scriptargs $*; res=$?
		fi
		[ $res != 0 ] && echo "The program returned an error code ($res)"
	fi
    [ "$keep" = y ] || { cd /tmp; /bin/rm -rf $tmpdir; }
else
  echo "Cannot decompress $0"; eval $finish; exit 1
fi
eval $finish; exit $res
END_OF_STUB
� �%�<�\tTE���	iB'/	Q��PP�1�:$-?����ӆ��t�t�ݯ1(��G���c�uGv��0+3�,q�$��2��E�ݣ�E=� We{ﭪ�?/���ew�عu�nݺu�V��ן]^\Q\VYB.竴��tڴ;���N�������R�"��**��U9�����VN� �;�x�b��b!����3����'��^�l���bk��2�Yiiee� �_^ZY^[���i��R:�����ٺ�.�N�u�@t	��VпI�#��G��RkR�-u�%�t"��ڈ��"�����)����ҋ�����h�������F:cTV���C]��L:cn����[4�+� 5 kk!�=  ��m�hE�s�$=d�2��֘$$h�N���c�҅�`�Du*��>�rg|<�67i�%�-�ONxᨭe�@��!Fc�S�&�m�t���	
^�m�@����F�NF�Jm�$�}�TH�T���@&t\̐f�@)F�za��w��!��ht���Ю�Ԍ@�4��9�&�����x
��#�z^ق�t��Y���l	��)�r?鰋z� �e"��l)���PBG�xcu"/�i�]�2���]+mXE�e�*�B��e��(�