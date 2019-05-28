---
id: 1717
title: Enforcing code style in Java
date: 2015-01-28T15:37:53+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2015/01/28/1716-revision-v1/
permalink: /2015/01/28/1716-revision-v1/
---
After many years of doing Java, I finally got around to enforcing code conventions in our project. The problem with code conventions is not agreeing on them but enforcing them. For this purpose you can choose from a wide variety of code checkers such as checkstyle. My problem with those is that they are too strict, too verbose, too annoying, and nobody ever checks their output anyway. So, pretty much every Java project I've ever been on had somewhat vague guidelines on code conventions and a very loose attitude to enforcing these. So, you end up with loads of variation in whitespace, bracket placement, etc.

I finally found a solution to this problem that is completely unintrusive: format source code as part of your maven build. 

<code>
<plugin><!-- mvn java-formatter:format -->
	<groupId>com.googlecode.maven-java-formatter-plugin</groupId>
	<artifactId>maven-java-formatter-plugin</artifactId>
	<version>0.4</version>
	<configuration>
		<configFile>${project.basedir}/inbot-formatter.xml</configFile>
	</configuration>

	<executions>
		<execution>
			<goals>
				<goal>format</goal>
			</goals>
		</execution>
	</executions>
</plugin>
</code>

This formats the code using the specified formatting settings xml file. This file is basically an exported version of the Eclipse code formatter settings. Intellij users can use this as well since recent versions have a code formatter that can read these settings. The only thing you need to take care off is the organize imports setting. Eclipse comes with a nice configuration that is very different from what Intellij does and it is a bit of a pain to fix in Intellij. Eclipse has a notion of import groups that are each sorted alphabetically. It comes with four of these groups that represent imports with different prefixes so, javax* and java.*, etc. are different groups. This behavior is tedious to emulate in Intellij and out of the scope of the exported code settings. For that reason, you may want to consider modifying things on the Eclipse side and simply remove all groups and simply organize all imports alphabetically. This behavior is easy to emulate on Intellij and you can configure both IDEs to organize imports on save (which is good practice). Also, make sure to not allow * imports and only import what you actually use.

So, now anyone doing a mvn clean install to build the project will automatically fix any formatting issues that they introduced. Also, the formatter can be quite conservative and if you set it up right, it won't mess up things like manually added new lines and other manual formatting that you typically want to keep. But it will fix the small issues like using spaces (or tabs, depending on your preferences), having whitespace around brackets, etc. 

Having this is actually really nice because it means you get fewer conflicts on formatting issues. Also, problems introduced by people with poor IDE configuration skills/a relaxed attitude to code conventions (you know who you are) will automatically get fixed this way. Win win. There's always the oddball developer out there who insists on using vi, emacs, notepad, or something else that most IDE users would consider cruel and unusual punishment. Not a problem anymore. These massochists will notice that that whatever they think is correct Java might cause the build to create a few diffs on their edits. Ideally, this happens before they commit. And if not, you can yell at them them for committing untested code. 