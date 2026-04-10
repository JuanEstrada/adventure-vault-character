.PHONY: tokscale tokscale-light tokscale-week tokscale-month tokscale-json

# Tokscale — token usage tracking for AI coding agents
# https://github.com/junhoyeo/tokscale

tokscale:
	@npx tokscale@latest

tokscale-light:
	@npx tokscale@latest --light

tokscale-week:
	@npx tokscale@latest --week

tokscale-month:
	@npx tokscale@latest --month

tokscale-json:
	@npx tokscale@latest --json

tokscale-opencode:
	@npx tokscale@latest --opencode

tokscale-models:
	@npx tokscale@latest models

tokscale-wrapped:
	@npx tokscale@latest wrapped
