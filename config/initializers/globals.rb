# frozen_string_literal: true

SECRET_TOKEN = 'Random_Value'

PASSWORD_FORMAT = /\A
  (?=.{8,})
  (?=.*\d)
  (?=.*[a-z])
  (?=.*[A-Z])
  (?=.*[[:^alnum:]])
/x
