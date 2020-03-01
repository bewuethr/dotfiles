all

# Require dash for unordered lists
rule 'MD004', :style => :dash

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

# Ignor code block rule, there seems to be a bug
exclude_rule 'MD046'
