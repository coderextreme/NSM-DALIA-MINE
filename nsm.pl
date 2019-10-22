%primes = {};
@titles = ();
while (<STDIN>) {
	chomp;
	$title = $_;
	@sentences = ();
	$line = <STDIN>;
	while ($line =~ /^.+$/) {
		$sentence = $line;
		chomp $sentence;
		push (@sentences, ($sentence));
		$line = <STDIN>;
	}

	push (@titles, $title);
	$primes{$title} = '"'.join('", "', @sentences).'"';
}

print ("<html>\n");
print ("	<head>\n");
print ("		<title>American Sign Language Natural Semantic Metalanguage</title>\n");
print ("	</head>\n");
print ("<body>\n");
print ("<script>\n");
print ("var oldprime = null;\n");
print ("function addTerminal(terminal) {\n");
print ("	var sentence = document.getElementById('newSentence');\n");
print ("	var textNode = document.createTextNode(terminal);\n");
print ("	sentence.appendChild(textNode);\n");
print ("	var space = document.createTextNode(' ');\n");
print ("	sentence.appendChild(space);\n");
print ("}\n");
print ("function editSentences(newprime) {\n");
print ("	var newSentence = document.getElementById('newSentence');\n");
print ("	if (newSentence !== null && oldprime !== null) {\n");
print ("		var title = document.getElementById(oldprime);\n");
print ("		var click = title.getAttribute('onclick');\n");
print ("		title.setAttribute('onclick', click.substring(0, click.length-2)+', \"'+newSentence.innerHTML+'\");');\n");
print ("	}\n");
print ("	oldprime = newprime;\n");
print ("	var sentences = document.getElementById('sentences');\n");
print ("	while (sentences.firstChild) {\n");
print ("		sentences.removeChild(sentences.firstChild);\n");
print ("	}\n");
print ("	var div = document.createElement('div');\n");
print ("	for (var s = 1; s < arguments.length; s++) {\n");
print ("		var span = document.createElement('span');\n");
print ("		div.appendChild(span);\n");
print ("		var a = document.createElement('a');\n");
print ("	        a.setAttribute('href', 'https://www.signingsavvy.com/sign/'+arguments[s]);\n");
print ("		span.appendChild(a);\n");
print ("		var textNode = document.createTextNode(arguments[s]);\n");
print ("		a.appendChild(textNode);\n");
print ("		var br = document.createElement('br');\n");
print ("		div.appendChild(br);\n");
print ("	}\n");
print ("	var sentence = document.createElement('span');\n");
print ("	sentence.setAttribute('id', 'newSentence');\n");
print ("	div.appendChild(sentence);\n");
print ("	var nbr = document.createElement('br');\n");
print ("	div.appendChild(nbr);\n");
print ("	sentences.appendChild(div);\n");
print ("}\n");
print ("</script>\n");
print ("<h1>Semantic Primes (click to add, edit sentence examples of this prime)</h1>\n");
print ("<div>\n");
foreach (@titles) {
	$video = `grep -w "$_" videos.txt`;
	$video =~ s/.*\/(.*)/mp4s\/$1/;
	print ("<button><video height='64' width='64' src='$video' id='".$_."' onclick='editSentences(\"".$_."\", ".$primes{$_}.");'></video><a href=\"https://www.signingsavvy.com/sign/".$_."\">".$_."</a></button>\n");
}
print ("</div>\n");

print "\n";

print ("<div id='sentences'>\n");
print ("</div>\n");

print "\n";

print ("<h1>Syntactic Frame Elements (click to add to current sentence)</h1>\n");
print ("<div>\n");
foreach (@titles) {
	$video = `grep -w "$_" videos.txt`;
	$video =~ s/.*\/(.*)/mp4s\/$1/;
	print ("<button onclick='addTerminal(\"".$_."\"); return false;'><video height='64' width='64' src='$video' id='".$_."' onclick='addTerminal(\"".$_."\"); return false;'></video><a href=\"https://www.signingsavvy.com/sign/".$_."\">".$_."</a></button>\n");
}
print ("</div>\n");
print ("</body>\n");
print ("</html>\n");