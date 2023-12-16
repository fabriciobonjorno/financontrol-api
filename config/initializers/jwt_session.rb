# frozen_string_literal: true

JWTSessions.signing_key = Rails.application.credentials.secret_key_base
JWTSessions.algorithm = 'HS256'
JWTSessions.access_exp_time = 3600 # 1 hour in seconds
JWTSessions.refresh_exp_time = 604_800 # 1 week in seconds
