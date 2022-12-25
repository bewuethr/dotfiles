all

# Require dash for unordered lists
rule 'MD004', :style => :dash

# Ignore inconsistend list indentation; required because we want to set rule 7
# to 2 spaces
exclude_rule 'MD005'

# Require nested unordered lists to be indented by 2 spaces
rule 'MD007', :indent => 2

# Don't enforce line length
exclude_rule 'MD013'

# Allow duplicate titles
exclude_rule 'MD024'

# Allow titles to end in question marks
rule 'MD026', :punctuation => '.,;:!'

# Don't force ordered lists with 1. 1. 1.
rule 'MD029', :style => :ordered

# Allow inline HTML
exclude_rule 'MD033'

# Allow bare URLs
exclude_rule 'MD034'

# Don't require a language on fenced codeblocks
exclude_rule 'MD040'

# Ignore code block rule, there seems to be a bug
exclude_rule 'MD046'
