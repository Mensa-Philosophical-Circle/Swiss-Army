#!/usr/bin/env bash
# Security: no secret in the code, no plain http, no token in plain storage.
set -euo pipefail

VIOLATIONS=0

SECRETS=$(grep -rnE "(AKIA[0-9A-Z]{16}|sk_live_[0-9a-zA-Z]{24}|AIza[0-9A-Za-z_-]{35}|-----BEGIN (RSA|EC|OPENSSH|PRIVATE) KEY-----)" lib/ || true)
if [ -n "$SECRETS" ]; then
  echo "❌ Something that looks like a secret is in lib/ (keep secrets out of the app):"
  echo "$SECRETS"
  VIOLATIONS=$((VIOLATIONS + 1))
fi

HTTP=$(grep -rnE "['\"]http://" lib/ | grep -vE "(localhost|127\.0\.0\.1|10\.0\.2\.2)" || true)
if [ -n "$HTTP" ]; then
  echo "❌ Plain http:// address. Use https://:"
  echo "$HTTP"
  VIOLATIONS=$((VIOLATIONS + 1))
fi

PLAIN_TOKENS=$(grep -rnE "(SharedPreferences|GetStorage).*(setString|write).*(token|jwt|bearer)" lib/ || true)
if [ -n "$PLAIN_TOKENS" ]; then
  echo "❌ A sign-in token in plain storage. Use flutter_secure_storage:"
  echo "$PLAIN_TOKENS"
  VIOLATIONS=$((VIOLATIONS + 1))
fi

if [ "$VIOLATIONS" -gt 0 ]; then
  exit 1
fi
echo "✅ No secrets, plain http or plain-stored tokens."
