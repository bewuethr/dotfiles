all

# Use MD041 instead
exclude_rule 'MD002'

# Require ATX-style headers
rule 'MD003', :style => :atx

# Require dashes for unordered lists
rule 'MD004', :style => :dash

# Ignore inconsistend list indentation; required because we want to set rule 7
# to 2 spaces
exclude_rule 'MD005'

# Require nested unordered lists to be indented by 2 spaces
rule 'MD007', :indent => 2

# Allow exactly 2 breaking spaces at the end of a line
rule 'MD009', :br_spaces => 2

# Don't enforce line length in code blocks and tables
rule 'MD013', :ignore_code_blocks => true, :tables => false

# Allow duplicate titles
exclude_rule 'MD024'

# Allow titles to end in question marks
rule 'MD026', :punctuation => '.,;:!'

# Don't force ordered lists with 1. 1. 1.
rule 'MD029', :style => :ordered

# Allow inline HTML
exclude_rule 'MD033'

# Require "---" for horizontal rules
rule 'MD035', :style => '---'
