https://docs.docker.com/engine/reference/builder/
http://localhost:9000

$ sudo docker build . -t aozdemir/docsengine:dockerignore-file


This file causes the following build behavior:

Rule	Behavior
# comment	Ignored.
*/temp*	Exclude files and directories whose names start with temp in any immediate subdirectory of the root. For example, the plain file /somedir/temporary.txt is excluded, as is the directory /somedir/temp.
*/*/temp*	Exclude files and directories starting with temp from any subdirectory that is two levels below the root. For example, /somedir/subdir/temporary.txt is excluded.
temp?	Exclude files and directories in the root directory whose names are a one-character extension of temp. For example, /tempa and /tempb are excluded.

Lines starting with ! (exclamation mark) can be used to make exceptions to exclusions. The following is an example .dockerignore file that uses this mechanism:

    *.md
    !README.md
    
All markdown files except README.md are excluded from the context.

The placement of ! exception rules influences the behavior: the last line of the .dockerignore that matches a particular file determines whether it is included or excluded. Consider the following example:

    *.md
    !README*.md
    README-secret.md

No markdown files are included in the context except README files other than README-secret.md.

Now consider this example:

    *.md
    README-secret.md
    !README*.md

All of the README files are included. The middle line has no effect because !README*.md matches README-secret.md and comes last.

