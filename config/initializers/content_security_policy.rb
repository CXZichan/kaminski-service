# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy.
# See the Securing Rails Applications Guide for more information:
# https://guides.rubyonrails.org/security.html#content-security-policy-header

Rails.application.configure do
  config.content_security_policy do |policy|
    policy.default_src :self
    policy.font_src :self, :data
    policy.img_src :self, :data
    policy.object_src :none
    policy.script_src :self
    policy.style_src :self, :unsafe_inline
    policy.connect_src :self
    policy.frame_ancestors :none
    policy.base_uri :self
    policy.form_action :self
  end

  config.content_security_policy_nonce_generator = ->(request) { request.session.id.to_s }
  config.content_security_policy_nonce_directives = %w[script-src]
  config.action_dispatch.default_headers["Referrer-Policy"] = "strict-origin-when-cross-origin"
  config.action_dispatch.default_headers["Permissions-Policy"] = "camera=(), microphone=(), geolocation=(), payment=()"
  config.action_dispatch.default_headers["X-Content-Type-Options"] = "nosniff"
end
