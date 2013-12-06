# This is a file there will be stored your team name, or else text which you wanna to out
# on server start or console start. He must be in Constant with hash structure like:
#
#  Params = {
#   key1: 'value'
#   key2: 'value'
#  }
#
# Examples:
# If i want to write just line string use this:
#
#  Params = {
#   team_name: "Exaple-team"
#  }
#
# Also, you can write it like "space" string:
#
#  Params = {
#   key1: 'line1 
#          line2 
#          line3 
#          line4 '
#  }
#
# Notice: Be careful use "/" - this is special symbol
#         will be needed // because one of them should be shielded.
#         Or you can use
#         <<-'text'
#         /example/
#         text
#
# Also, you can add as many values as you want.
# They will be withdrawn in order as you wrote them here
#
#  Params = {
#   line1:  'Hello' => Should be first
#   line2:  'World' => Should be second
#  }
#
# In console we got:
# "Hello"
# "World"
#
# Also, you can use rails variables here. Or whatever you want.
# Before you define IMPORTANT constant "Params" you can any rails operations as you wish.
# For example:
#  
#  user_count = User.count
#  Params = {
#   title: "Welcome to my server!"
#   user: "Here is #{user_count} users on your site"
#  }
#
# VERY IMPORTANT: YOU CAN USE ONLY CONSTANT WITH NAME "Params"
#

# Simple example of use:
b = 10 + 5
Params = {
    tea_size: "Our team size is:#{b} developers",
    team_name:
'  ____________      _________    ____________
  |-----____---1   |-- ___ --|  |-----____---1
  |----1----1---1  |--|---|--|  |----1----1---1
  |---|------|---| |--|---|--|  |---|------|---|
  |----1____1---|  |--|---|--|  |----1____1---|
  |------------1   |--|---|--|  |------------1
  |-----------1    |--|---|--|  |-----------1
  |------|----1    |--|---|--|  |------|----1
  |------|-----1   |--|___|--|  |------|-----1
  |______|______1  |_________|  |______|______1'
}
