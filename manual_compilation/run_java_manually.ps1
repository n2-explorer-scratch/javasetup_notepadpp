# I needed to ask MS Copilot about syntax and method parameters, I don't know too much about PowerShell. But I made the program logic.

$JAVA_PATH = "<add absolute java path here>"

$programfile = $args[0]
cd (split-path $programfile -parent)

while (-not (test-path ".\src")) {
	if ("$pwd" -eq "C:\") {
		echo "Could not find project parent directory `(must contain \src`)"
		exit
	}
	cd ..
}

# incremental compilation
if (-not (test-path "hashes.txt" -pathtype leaf)) {
	echo "" > hashes.txt
}

# library reference
if (-not (test-path "libs" -pathtype container)) {
	mkdir libs
}

$hashes = get-content hashes.txt
$hashmap = @{}
$changed = @() #empty

for ($i = 0; $i -lt $hashes.Count; $i++) {
    if ($hashes[$i] -match "^(.*?);(.*)") {
        $hashmap[$matches[1]] = @{ hash = $matches[2]; index = $i }
    }
}

# checking all \src java files
(ls -filter *.java -file -recurse -name) `
	| foreach-object {
		$hash = (get-filehash $_ -alg sha256).hash
		
		# if file exists in scan
		if ($hashmap.containsKey($_)) {
			$old = $hashmap[$_]
			
			# if hashes are identical
			if ($hash -eq $old.hash) {
				return
			} else {
				$hashes[$old.index] = "$_;$hash`n"
				$changed += $_
			}
		} else {
			$hashes += "$_;$hash`n"
			$changed += $_
		}
	}

set-content hashes.txt -value $hashes -encoding ascii
set-content changed.txt -value $changed -encoding ascii

echo "$JAVA_PATH\bin\javac @changed.txt -d bin -cp .;libs\*"
$javacprocess = start-process -nonewwindow `
    -filepath "$JAVA_PATH\bin\javac.exe" `
    -argumentlist "@changed.txt", "-d", "bin", "-cp", ".;libs\*" `
    -wait `
	-passthru

if ($javacprocess.exitcode -eq 1) {
	echo ""
	echo "RUNNING 1 OR MORE PREVIOUS CLASS VERSIONS! `(see compile error`)"

    $bad = $changed
    $newhashes = @()

    foreach ($line in $hashes) {
        $file, $h = $line -split ';'
        if ($bad -notcontains $file) {
            $newhashes += $line
        }
    }

    # update hashes.txt
    set-content hashes.txt -value $newhashes -encoding ascii
}

$programclass = $programfile -replace '^.*?src[\\/]', '' -replace '\\', '.' -replace '/', '.' -replace '\.java$', ''

echo "$JAVA_PATH\bin\java -cp bin;libs\* $programclass"
start-process -nonewwindow `
    -filepath "$JAVA_PATH\bin\java.exe" `
    -argumentlist "-cp", "bin;libs\*", "$programclass" `
    -wait
