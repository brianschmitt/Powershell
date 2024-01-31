using namespace System.Management.Automation
using namespace System.Management.Automation.Language

Register-ArgumentCompleter -Native -CommandName 'rg' -ScriptBlock {
  param($wordToComplete, $commandAst, $cursorPosition)
  $commandElements = $commandAst.CommandElements
  $command = @(
    'rg'
    for ($i = 1; $i -lt $commandElements.Count; $i++) {
        $element = $commandElements[$i]
        if ($element -isnot [StringConstantExpressionAst] -or
            $element.StringConstantType -ne [StringConstantType]::BareWord -or
            $element.Value.StartsWith('-')) {
            break
    }
    $element.Value
  }) -join ';'

  $completions = @(switch ($command) {
    'rg' {
      [CompletionResult]::new('--regexp', 'regexp', [CompletionResultType]::ParameterName, 'A pattern to search for.')
      [CompletionResult]::new('-e', 'e', [CompletionResultType]::ParameterName, 'A pattern to search for.')
      [CompletionResult]::new('--file', 'file', [CompletionResultType]::ParameterName, 'Search for patterns from the given file.')
      [CompletionResult]::new('-f', 'f', [CompletionResultType]::ParameterName, 'Search for patterns from the given file.')
      [CompletionResult]::new('--after-context', 'after-context', [CompletionResultType]::ParameterName, 'Show NUM lines after each match.')
      [CompletionResult]::new('-A', 'A', [CompletionResultType]::ParameterName, 'Show NUM lines after each match.')
      [CompletionResult]::new('--before-context', 'before-context', [CompletionResultType]::ParameterName, 'Show NUM lines before each match.')
      [CompletionResult]::new('-B', 'B', [CompletionResultType]::ParameterName, 'Show NUM lines before each match.')
      [CompletionResult]::new('--binary', 'binary', [CompletionResultType]::ParameterName, 'Search binary files.')
      [CompletionResult]::new('--no-binary', 'no-binary', [CompletionResultType]::ParameterName, 'Search binary files.')
      [CompletionResult]::new('--block-buffered', 'block-buffered', [CompletionResultType]::ParameterName, 'Force block buffering.')
      [CompletionResult]::new('--no-block-buffered', 'no-block-buffered', [CompletionResultType]::ParameterName, 'Force block buffering.')
      [CompletionResult]::new('--byte-offset', 'byte-offset', [CompletionResultType]::ParameterName, 'Print the byte offset for each matching line.')
      [CompletionResult]::new('-b', 'b', [CompletionResultType]::ParameterName, 'Print the byte offset for each matching line.')
      [CompletionResult]::new('--no-byte-offset', 'no-byte-offset', [CompletionResultType]::ParameterName, 'Print the byte offset for each matching line.')
      [CompletionResult]::new('--case-sensitive', 'case-sensitive', [CompletionResultType]::ParameterName, 'Search case sensitively (default).')
      [CompletionResult]::new('-s', 's', [CompletionResultType]::ParameterName, 'Search case sensitively (default).')
      [CompletionResult]::new('--color', 'color', [CompletionResultType]::ParameterName, 'When to use color.')
      [CompletionResult]::new('--colors', 'colors', [CompletionResultType]::ParameterName, 'Configure color settings and styles.')
      [CompletionResult]::new('--column', 'column', [CompletionResultType]::ParameterName, 'Show column numbers.')
      [CompletionResult]::new('--no-column', 'no-column', [CompletionResultType]::ParameterName, 'Show column numbers.')
      [CompletionResult]::new('--context', 'context', [CompletionResultType]::ParameterName, 'Show NUM lines before and after each match.')
      [CompletionResult]::new('-C', 'C', [CompletionResultType]::ParameterName, 'Show NUM lines before and after each match.')
      [CompletionResult]::new('--context-separator', 'context-separator', [CompletionResultType]::ParameterName, 'Set the separator for contextual chunks.')
      [CompletionResult]::new('--no-context-separator', 'no-context-separator', [CompletionResultType]::ParameterName, 'Set the separator for contextual chunks.')
      [CompletionResult]::new('--count', 'count', [CompletionResultType]::ParameterName, 'Show count of matching lines for each file.')
      [CompletionResult]::new('-c', 'c', [CompletionResultType]::ParameterName, 'Show count of matching lines for each file.')
      [CompletionResult]::new('--count-matches', 'count-matches', [CompletionResultType]::ParameterName, 'Show count of every match for each file.')
      [CompletionResult]::new('--crlf', 'crlf', [CompletionResultType]::ParameterName, 'Use CRLF line terminators (nice for Windows).')
      [CompletionResult]::new('--no-crlf', 'no-crlf', [CompletionResultType]::ParameterName, 'Use CRLF line terminators (nice for Windows).')
      [CompletionResult]::new('--debug', 'debug', [CompletionResultType]::ParameterName, 'Show debug messages.')
      [CompletionResult]::new('--dfa-size-limit', 'dfa-size-limit', [CompletionResultType]::ParameterName, 'The upper size limit of the regex DFA.')
      [CompletionResult]::new('--encoding', 'encoding', [CompletionResultType]::ParameterName, 'Specify the text encoding of files to search.')
      [CompletionResult]::new('-E', 'E', [CompletionResultType]::ParameterName, 'Specify the text encoding of files to search.')
      [CompletionResult]::new('--no-encoding', 'no-encoding', [CompletionResultType]::ParameterName, 'Specify the text encoding of files to search.')
      [CompletionResult]::new('--engine', 'engine', [CompletionResultType]::ParameterName, 'Specify which regex engine to use.')
      [CompletionResult]::new('--field-context-separator', 'field-context-separator', [CompletionResultType]::ParameterName, 'Set the field context separator.')
      [CompletionResult]::new('--field-match-separator', 'field-match-separator', [CompletionResultType]::ParameterName, 'Set the field match separator.')
      [CompletionResult]::new('--files', 'files', [CompletionResultType]::ParameterName, 'Print each file that would be searched.')
      [CompletionResult]::new('--files-with-matches', 'files-with-matches', [CompletionResultType]::ParameterName, 'Print the paths with at least one match.')
      [CompletionResult]::new('-l', 'l', [CompletionResultType]::ParameterName, 'Print the paths with at least one match.')
      [CompletionResult]::new('--files-without-match', 'files-without-match', [CompletionResultType]::ParameterName, 'Print the paths that contain zero matches.')
      [CompletionResult]::new('--fixed-strings', 'fixed-strings', [CompletionResultType]::ParameterName, 'Treat all patterns as literals.')
      [CompletionResult]::new('-F', 'F', [CompletionResultType]::ParameterName, 'Treat all patterns as literals.')
      [CompletionResult]::new('--no-fixed-strings', 'no-fixed-strings', [CompletionResultType]::ParameterName, 'Treat all patterns as literals.')
      [CompletionResult]::new('--follow', 'follow', [CompletionResultType]::ParameterName, 'Follow symbolic links.')
      [CompletionResult]::new('-L', 'L', [CompletionResultType]::ParameterName, 'Follow symbolic links.')
      [CompletionResult]::new('--no-follow', 'no-follow', [CompletionResultType]::ParameterName, 'Follow symbolic links.')
      [CompletionResult]::new('--generate', 'generate', [CompletionResultType]::ParameterName, 'Generate man pages and completion scripts.')
      [CompletionResult]::new('--glob', 'glob', [CompletionResultType]::ParameterName, 'Include or exclude file paths.')
      [CompletionResult]::new('-g', 'g', [CompletionResultType]::ParameterName, 'Include or exclude file paths.')
      [CompletionResult]::new('--glob-case-insensitive', 'glob-case-insensitive', [CompletionResultType]::ParameterName, 'Process all glob patterns case insensitively.')
      [CompletionResult]::new('--no-glob-case-insensitive', 'no-glob-case-insensitive', [CompletionResultType]::ParameterName, 'Process all glob patterns case insensitively.')
      [CompletionResult]::new('--heading', 'heading', [CompletionResultType]::ParameterName, 'Print matches grouped by each file.')
      [CompletionResult]::new('--no-heading', 'no-heading', [CompletionResultType]::ParameterName, 'Print matches grouped by each file.')
      [CompletionResult]::new('--help', 'help', [CompletionResultType]::ParameterName, 'Show help output.')
      [CompletionResult]::new('-h', 'h', [CompletionResultType]::ParameterName, 'Show help output.')
      [CompletionResult]::new('--hidden', 'hidden', [CompletionResultType]::ParameterName, 'Search hidden files and directories.')
      [CompletionResult]::new('-.', '.', [CompletionResultType]::ParameterName, 'Search hidden files and directories.')
      [CompletionResult]::new('--no-hidden', 'no-hidden', [CompletionResultType]::ParameterName, 'Search hidden files and directories.')
      [CompletionResult]::new('--hostname-bin', 'hostname-bin', [CompletionResultType]::ParameterName, 'Run a program to get this system''s hostname.')
      [CompletionResult]::new('--hyperlink-format', 'hyperlink-format', [CompletionResultType]::ParameterName, 'Set the format of hyperlinks.')
      [CompletionResult]::new('--iglob', 'iglob', [CompletionResultType]::ParameterName, 'Include/exclude paths case insensitively.')
      [CompletionResult]::new('--ignore-case', 'ignore-case', [CompletionResultType]::ParameterName, 'Case insensitive search.')
      [CompletionResult]::new('-i', 'i', [CompletionResultType]::ParameterName, 'Case insensitive search.')
      [CompletionResult]::new('--ignore-file', 'ignore-file', [CompletionResultType]::ParameterName, 'Specify additional ignore files.')
      [CompletionResult]::new('--ignore-file-case-insensitive', 'ignore-file-case-insensitive', [CompletionResultType]::ParameterName, 'Process ignore files case insensitively.')
      [CompletionResult]::new('--no-ignore-file-case-insensitive', 'no-ignore-file-case-insensitive', [CompletionResultType]::ParameterName, 'Process ignore files case insensitively.')
      [CompletionResult]::new('--include-zero', 'include-zero', [CompletionResultType]::ParameterName, 'Include zero matches in summary output.')
      [CompletionResult]::new('--no-include-zero', 'no-include-zero', [CompletionResultType]::ParameterName, 'Include zero matches in summary output.')
      [CompletionResult]::new('--invert-match', 'invert-match', [CompletionResultType]::ParameterName, 'Invert matching.')
      [CompletionResult]::new('-v', 'v', [CompletionResultType]::ParameterName, 'Invert matching.')
      [CompletionResult]::new('--no-invert-match', 'no-invert-match', [CompletionResultType]::ParameterName, 'Invert matching.')
      [CompletionResult]::new('--json', 'json', [CompletionResultType]::ParameterName, 'Show search results in a JSON Lines format.')
      [CompletionResult]::new('--no-json', 'no-json', [CompletionResultType]::ParameterName, 'Show search results in a JSON Lines format.')
      [CompletionResult]::new('--line-buffered', 'line-buffered', [CompletionResultType]::ParameterName, 'Force line buffering.')
      [CompletionResult]::new('--no-line-buffered', 'no-line-buffered', [CompletionResultType]::ParameterName, 'Force line buffering.')
      [CompletionResult]::new('--line-number', 'line-number', [CompletionResultType]::ParameterName, 'Show line numbers.')
      [CompletionResult]::new('-n', 'n', [CompletionResultType]::ParameterName, 'Show line numbers.')
      [CompletionResult]::new('--no-line-number', 'no-line-number', [CompletionResultType]::ParameterName, 'Suppress line numbers.')
      [CompletionResult]::new('-N', 'N', [CompletionResultType]::ParameterName, 'Suppress line numbers.')
      [CompletionResult]::new('--line-regexp', 'line-regexp', [CompletionResultType]::ParameterName, 'Show matches surrounded by line boundaries.')
      [CompletionResult]::new('-x', 'x', [CompletionResultType]::ParameterName, 'Show matches surrounded by line boundaries.')
      [CompletionResult]::new('--max-columns', 'max-columns', [CompletionResultType]::ParameterName, 'Omit lines longer than this limit.')
      [CompletionResult]::new('-M', 'M', [CompletionResultType]::ParameterName, 'Omit lines longer than this limit.')
      [CompletionResult]::new('--max-columns-preview', 'max-columns-preview', [CompletionResultType]::ParameterName, 'Show preview for lines exceeding the limit.')
      [CompletionResult]::new('--no-max-columns-preview', 'no-max-columns-preview', [CompletionResultType]::ParameterName, 'Show preview for lines exceeding the limit.')
      [CompletionResult]::new('--max-count', 'max-count', [CompletionResultType]::ParameterName, 'Limit the number of matching lines.')
      [CompletionResult]::new('-m', 'm', [CompletionResultType]::ParameterName, 'Limit the number of matching lines.')
      [CompletionResult]::new('--max-depth', 'max-depth', [CompletionResultType]::ParameterName, 'Descend at most NUM directories.')
      [CompletionResult]::new('-d', 'd', [CompletionResultType]::ParameterName, 'Descend at most NUM directories.')
      [CompletionResult]::new('--max-filesize', 'max-filesize', [CompletionResultType]::ParameterName, 'Ignore files larger than NUM in size.')
      [CompletionResult]::new('--mmap', 'mmap', [CompletionResultType]::ParameterName, 'Search with memory maps when possible.')
      [CompletionResult]::new('--no-mmap', 'no-mmap', [CompletionResultType]::ParameterName, 'Search with memory maps when possible.')
      [CompletionResult]::new('--multiline', 'multiline', [CompletionResultType]::ParameterName, 'Enable searching across multiple lines.')
      [CompletionResult]::new('-U', 'U', [CompletionResultType]::ParameterName, 'Enable searching across multiple lines.')
      [CompletionResult]::new('--no-multiline', 'no-multiline', [CompletionResultType]::ParameterName, 'Enable searching across multiple lines.')
      [CompletionResult]::new('--multiline-dotall', 'multiline-dotall', [CompletionResultType]::ParameterName, 'Make ''.'' match line terminators.')
      [CompletionResult]::new('--no-multiline-dotall', 'no-multiline-dotall', [CompletionResultType]::ParameterName, 'Make ''.'' match line terminators.')
      [CompletionResult]::new('--no-config', 'no-config', [CompletionResultType]::ParameterName, 'Never read configuration files.')
      [CompletionResult]::new('--no-ignore', 'no-ignore', [CompletionResultType]::ParameterName, 'Don''t use ignore files.')
      [CompletionResult]::new('--ignore', 'ignore', [CompletionResultType]::ParameterName, 'Don''t use ignore files.')
      [CompletionResult]::new('--no-ignore-dot', 'no-ignore-dot', [CompletionResultType]::ParameterName, 'Don''t use .ignore or .rgignore files.')
      [CompletionResult]::new('--ignore-dot', 'ignore-dot', [CompletionResultType]::ParameterName, 'Don''t use .ignore or .rgignore files.')
      [CompletionResult]::new('--no-ignore-exclude', 'no-ignore-exclude', [CompletionResultType]::ParameterName, 'Don''t use local exclusion files.')
      [CompletionResult]::new('--ignore-exclude', 'ignore-exclude', [CompletionResultType]::ParameterName, 'Don''t use local exclusion files.')
      [CompletionResult]::new('--no-ignore-files', 'no-ignore-files', [CompletionResultType]::ParameterName, 'Don''t use --ignore-file arguments.')
      [CompletionResult]::new('--ignore-files', 'ignore-files', [CompletionResultType]::ParameterName, 'Don''t use --ignore-file arguments.')
      [CompletionResult]::new('--no-ignore-global', 'no-ignore-global', [CompletionResultType]::ParameterName, 'Don''t use global ignore files.')
      [CompletionResult]::new('--ignore-global', 'ignore-global', [CompletionResultType]::ParameterName, 'Don''t use global ignore files.')
      [CompletionResult]::new('--no-ignore-messages', 'no-ignore-messages', [CompletionResultType]::ParameterName, 'Suppress gitignore parse error messages.')
      [CompletionResult]::new('--ignore-messages', 'ignore-messages', [CompletionResultType]::ParameterName, 'Suppress gitignore parse error messages.')
      [CompletionResult]::new('--no-ignore-parent', 'no-ignore-parent', [CompletionResultType]::ParameterName, 'Don''t use ignore files in parent directories.')
      [CompletionResult]::new('--ignore-parent', 'ignore-parent', [CompletionResultType]::ParameterName, 'Don''t use ignore files in parent directories.')
      [CompletionResult]::new('--no-ignore-vcs', 'no-ignore-vcs', [CompletionResultType]::ParameterName, 'Don''t use ignore files from source control.')
      [CompletionResult]::new('--ignore-vcs', 'ignore-vcs', [CompletionResultType]::ParameterName, 'Don''t use ignore files from source control.')
      [CompletionResult]::new('--no-messages', 'no-messages', [CompletionResultType]::ParameterName, 'Suppress some error messages.')
      [CompletionResult]::new('--messages', 'messages', [CompletionResultType]::ParameterName, 'Suppress some error messages.')
      [CompletionResult]::new('--no-require-git', 'no-require-git', [CompletionResultType]::ParameterName, 'Use .gitignore outside of git repositories.')
      [CompletionResult]::new('--require-git', 'require-git', [CompletionResultType]::ParameterName, 'Use .gitignore outside of git repositories.')
      [CompletionResult]::new('--no-unicode', 'no-unicode', [CompletionResultType]::ParameterName, 'Disable Unicode mode.')
      [CompletionResult]::new('--unicode', 'unicode', [CompletionResultType]::ParameterName, 'Disable Unicode mode.')
      [CompletionResult]::new('--null', 'null', [CompletionResultType]::ParameterName, 'Print a NUL byte after file paths.')
      [CompletionResult]::new('-0', '0', [CompletionResultType]::ParameterName, 'Print a NUL byte after file paths.')
      [CompletionResult]::new('--null-data', 'null-data', [CompletionResultType]::ParameterName, 'Use NUL as a line terminator.')
      [CompletionResult]::new('--one-file-system', 'one-file-system', [CompletionResultType]::ParameterName, 'Skip directories on other file systems.')
      [CompletionResult]::new('--no-one-file-system', 'no-one-file-system', [CompletionResultType]::ParameterName, 'Skip directories on other file systems.')
      [CompletionResult]::new('--only-matching', 'only-matching', [CompletionResultType]::ParameterName, 'Print only matched parts of a line.')
      [CompletionResult]::new('-o', 'o', [CompletionResultType]::ParameterName, 'Print only matched parts of a line.')
      [CompletionResult]::new('--path-separator', 'path-separator', [CompletionResultType]::ParameterName, 'Set the path separator for printing paths.')
      [CompletionResult]::new('--passthru', 'passthru', [CompletionResultType]::ParameterName, 'Print both matching and non-matching lines.')
      [CompletionResult]::new('--pcre2', 'pcre2', [CompletionResultType]::ParameterName, 'Enable PCRE2 matching.')
      [CompletionResult]::new('-P', 'P', [CompletionResultType]::ParameterName, 'Enable PCRE2 matching.')
      [CompletionResult]::new('--no-pcre2', 'no-pcre2', [CompletionResultType]::ParameterName, 'Enable PCRE2 matching.')
      [CompletionResult]::new('--pcre2-version', 'pcre2-version', [CompletionResultType]::ParameterName, 'Print the version of PCRE2 that ripgrep uses.')
      [CompletionResult]::new('--pre', 'pre', [CompletionResultType]::ParameterName, 'Search output of COMMAND for each PATH.')
      [CompletionResult]::new('--no-pre', 'no-pre', [CompletionResultType]::ParameterName, 'Search output of COMMAND for each PATH.')
      [CompletionResult]::new('--pre-glob', 'pre-glob', [CompletionResultType]::ParameterName, 'Include or exclude files from a preprocessor.')
      [CompletionResult]::new('--pretty', 'pretty', [CompletionResultType]::ParameterName, 'Alias for colors, headings and line numbers.')
      [CompletionResult]::new('-p', 'p', [CompletionResultType]::ParameterName, 'Alias for colors, headings and line numbers.')
      [CompletionResult]::new('--quiet', 'quiet', [CompletionResultType]::ParameterName, 'Do not print anything to stdout.')
      [CompletionResult]::new('-q', 'q', [CompletionResultType]::ParameterName, 'Do not print anything to stdout.')
      [CompletionResult]::new('--regex-size-limit', 'regex-size-limit', [CompletionResultType]::ParameterName, 'The size limit of the compiled regex.')
      [CompletionResult]::new('--replace', 'replace', [CompletionResultType]::ParameterName, 'Replace matches with the given text.')
      [CompletionResult]::new('-r', 'r', [CompletionResultType]::ParameterName, 'Replace matches with the given text.')
      [CompletionResult]::new('--search-zip', 'search-zip', [CompletionResultType]::ParameterName, 'Search in compressed files.')
      [CompletionResult]::new('-z', 'z', [CompletionResultType]::ParameterName, 'Search in compressed files.')
      [CompletionResult]::new('--no-search-zip', 'no-search-zip', [CompletionResultType]::ParameterName, 'Search in compressed files.')
      [CompletionResult]::new('--smart-case', 'smart-case', [CompletionResultType]::ParameterName, 'Smart case search.')
      [CompletionResult]::new('-S', 'S', [CompletionResultType]::ParameterName, 'Smart case search.')
      [CompletionResult]::new('--sort', 'sort', [CompletionResultType]::ParameterName, 'Sort results in ascending order.')
      [CompletionResult]::new('--sortr', 'sortr', [CompletionResultType]::ParameterName, 'Sort results in descending order.')
      [CompletionResult]::new('--stats', 'stats', [CompletionResultType]::ParameterName, 'Print statistics about the search.')
      [CompletionResult]::new('--no-stats', 'no-stats', [CompletionResultType]::ParameterName, 'Print statistics about the search.')
      [CompletionResult]::new('--stop-on-nonmatch', 'stop-on-nonmatch', [CompletionResultType]::ParameterName, 'Stop searching after a non-match.')
      [CompletionResult]::new('--text', 'text', [CompletionResultType]::ParameterName, 'Search binary files as if they were text.')
      [CompletionResult]::new('-a', 'a', [CompletionResultType]::ParameterName, 'Search binary files as if they were text.')
      [CompletionResult]::new('--no-text', 'no-text', [CompletionResultType]::ParameterName, 'Search binary files as if they were text.')
      [CompletionResult]::new('--threads', 'threads', [CompletionResultType]::ParameterName, 'Set the approximate number of threads to use.')
      [CompletionResult]::new('-j', 'j', [CompletionResultType]::ParameterName, 'Set the approximate number of threads to use.')
      [CompletionResult]::new('--trace', 'trace', [CompletionResultType]::ParameterName, 'Show trace messages.')
      [CompletionResult]::new('--trim', 'trim', [CompletionResultType]::ParameterName, 'Trim prefix whitespace from matches.')
      [CompletionResult]::new('--no-trim', 'no-trim', [CompletionResultType]::ParameterName, 'Trim prefix whitespace from matches.')
      [CompletionResult]::new('--type', 'type', [CompletionResultType]::ParameterName, 'Only search files matching TYPE.')
      [CompletionResult]::new('-t', 't', [CompletionResultType]::ParameterName, 'Only search files matching TYPE.')
      [CompletionResult]::new('--type-not', 'type-not', [CompletionResultType]::ParameterName, 'Do not search files matching TYPE.')
      [CompletionResult]::new('-T', 'T', [CompletionResultType]::ParameterName, 'Do not search files matching TYPE.')
      [CompletionResult]::new('--type-add', 'type-add', [CompletionResultType]::ParameterName, 'Add a new glob for a file type.')
      [CompletionResult]::new('--type-clear', 'type-clear', [CompletionResultType]::ParameterName, 'Clear globs for a file type.')
      [CompletionResult]::new('--type-list', 'type-list', [CompletionResultType]::ParameterName, 'Show all supported file types.')
      [CompletionResult]::new('--unrestricted', 'unrestricted', [CompletionResultType]::ParameterName, 'Reduce the level of "smart" filtering.')
      [CompletionResult]::new('-u', 'u', [CompletionResultType]::ParameterName, 'Reduce the level of "smart" filtering.')
      [CompletionResult]::new('--version', 'version', [CompletionResultType]::ParameterName, 'Print ripgrep''s version.')
      [CompletionResult]::new('-V', 'V', [CompletionResultType]::ParameterName, 'Print ripgrep''s version.')
      [CompletionResult]::new('--vimgrep', 'vimgrep', [CompletionResultType]::ParameterName, 'Print results im a vim compatible format.')
      [CompletionResult]::new('--with-filename', 'with-filename', [CompletionResultType]::ParameterName, 'Print the file path with each matching line.')
      [CompletionResult]::new('-H', 'H', [CompletionResultType]::ParameterName, 'Print the file path with each matching line.')
      [CompletionResult]::new('--no-filename', 'no-filename', [CompletionResultType]::ParameterName, 'Never print the path with each matching line.')
      [CompletionResult]::new('-I', 'I', [CompletionResultType]::ParameterName, 'Never print the path with each matching line.')
      [CompletionResult]::new('--word-regexp', 'word-regexp', [CompletionResultType]::ParameterName, 'Show matches surrounded by word boundaries.')
      [CompletionResult]::new('-w', 'w', [CompletionResultType]::ParameterName, 'Show matches surrounded by word boundaries.')
      [CompletionResult]::new('--auto-hybrid-regex', 'auto-hybrid-regex', [CompletionResultType]::ParameterName, '(DEPRECATED) Use PCRE2 if appropriate.')
      [CompletionResult]::new('--no-auto-hybrid-regex', 'no-auto-hybrid-regex', [CompletionResultType]::ParameterName, '(DEPRECATED) Use PCRE2 if appropriate.')
      [CompletionResult]::new('--no-pcre2-unicode', 'no-pcre2-unicode', [CompletionResultType]::ParameterName, '(DEPRECATED) Disable Unicode mode for PCRE2.')
      [CompletionResult]::new('--pcre2-unicode', 'pcre2-unicode', [CompletionResultType]::ParameterName, '(DEPRECATED) Disable Unicode mode for PCRE2.')
      [CompletionResult]::new('--sort-files', 'sort-files', [CompletionResultType]::ParameterName, '(DEPRECATED) Sort results by file path.')
      [CompletionResult]::new('--no-sort-files', 'no-sort-files', [CompletionResultType]::ParameterName, '(DEPRECATED) Sort results by file path.')
    }
  })

  $completions.Where{ $_.CompletionText -like "$wordToComplete*" } |
    Sort-Object -Property ListItemText
}
