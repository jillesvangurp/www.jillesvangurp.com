---
id: 1721
title: Enforcing code conventions in Java
date: 2015-01-29T11:36:10+00:00
author: Jilles
layout: revision
guid: http://www.jillesvangurp.com/2015/01/29/1716-revision-v1/
permalink: /2015/01/29/1716-revision-v1/
---
After many years of working with Java, I finally got around to enforcing code conventions in our project. The problem with code conventions is not agreeing on them (actually this is hard since everybody seems to have their own preferences but that's beside the point) but enforcing them. For the purpose of enforcing conventions you can choose from a wide variety of code checkers such as checkstyle, pmd, and others. My problem with this approach is that checkers usually end up being a combination of too strict, too verbose, or too annoying. In any case nobody ever checks their output and you need to have the discipline to fix things yourself for any issues detected. Most projects I've tried checkstyle on, it finds thousands of stupid issues using the out of the box configuration. Pretty much every Java project I've ever been involved with had somewhat vague guidelines on code conventions and a very loose attitude to enforcing these. So, you end up with loads of variation in whitespace, bracket placement, etc. Eventually people stop caring. It's not a problem worthy of a lot of brain cycles and we are all busy.

Anyway, I finally found [a solution](https://code.google.com/p/maven-java-formatter-plugin/) to this problem that is completely unintrusive: format source code as part of your build. Simply add the following blurb to your maven build section and save some formatter settings in XML format in your source tree. It won't fix all your issues but formatting related diffs should be a thing of the past. Either your code is fine, in which case it will pass the formatter unmodified or you messed up, in which case the formatter will fix it for you.

```
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
```

This plugin formats the code using the specified formatting settings XML file and it executes every build before compilation. You can create the settings file by exporting the Eclipse code formatter settings. [Intellij users can use these settings as well](http://blog.jetbrains.com/idea/2014/01/intellij-idea-13-importing-code-formatter-settings-from-eclipse/) since recent versions support the eclipse formatter settings file format. The only thing you need to take care off is the organize imports settings in both IDEs. Eclipse comes with a default configuration that is very different from what Intellij does and it is a bit of a pain to fix on the Intellij side. Eclipse has a notion of import groups that are each sorted alphabetically. It comes with four of these groups that represent imports with different prefixes so, javax.* and java.*, etc. are different groups. This behavior is very tedious to emulate in Intellij and out of the scope of the exported formatter settings. For that reason, you may want to consider modifying things on the Eclipse side and simply remove all groups and simply sort all imports alphabetically. [This behavior is easy to emulate on Intellij](http://stackoverflow.com/questions/14716283/is-it-possible-for-intellij-to-organize-imports-the-same-way-as-in-eclipse) and you can configure both IDEs to organize imports on save, which is good practice. Also, make sure to not allow .* imports and only import what you actually use (why load classes you don't need?). If everybody does this, the only people causing problems will be those with poorly configured IDEs and their code will get fixed automatically over time.

Anyone doing a mvn clean install to build the project will automatically fix any formatting issues that they or others introduced. Also, the formatter can be configured conservatively and if you set it up right, it won't mess up things like manually added new lines and other manual formatting that you typically want to keep. But it will fix the small issues like using the right number of spaces (or tabs, depending on your preferences), having whitespace around brackets, braces, etc. The best part: it only adds about 1 second to your build time. So, you can set this up and it basically just works in a way that is completely unintrusive.

Compliance problems introduced by people with poor IDE configuration skills/a relaxed attitude to code conventions (you know who you are) will automatically get fixed this way. Win win. There's always the odd developer out there who insists on using vi, emacs, notepad, or something similarly archaic that most IDE users would consider cruel and unusual punishment. Not a problem anymore, let them. These masochists will notice that whatever they think is correctly formatted Java might cause the build to create a few diffs on their edits. Ideally, this happens before they commit. And if not, you can yell at them for committing untested code: no excuses for not building your project before a commit.