function decompile_apk() {
	wrkdir=$(pwd)
	trap "cd $wrkdir" EXIT

	apkname=$(basename $@)
	dirname="${apkname%.*}"
	# decompile apk
	apktool d -o $dirname $@ 

	# generate dex file
	cd $dirname
	apktool b
	cd build/apk

	# generate class files
	d2j-dex2jar classes.dex
	unzip classes-dex2jar.jar -d src

	# generate java files
	cd src
	find . -name "*.class" -exec jad -r -s java {} \;

	# cleanup generated files
	find . -name "*.class" -exec rm {} \;
	cd ..

	rm classes.dex classes-dex2jar.jar
}