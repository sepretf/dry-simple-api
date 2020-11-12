# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  include SendGrid

  default from: 'no-reply@plezi.co'

  layout 'mailer'

  def initialize(
    smtp_settings:           SMTP::SettingsService.new,
    default_tenant_username: ENV['SG_STARTER_USERNAME'],
    default_tenant_password: ENV['SG_PASSWORD'],
    default_tenant_host:     ENV['SG_HOST_URL'],
    default_tenant_key:      ENV['SG_TENANT_DEFAULT_KEY']
  )
    @smtp_settings           = smtp_settings
    @default_tenant_username = default_tenant_username
    @default_tenant_password = default_tenant_password
    @default_tenant_host     = default_tenant_host
    @default_tenant_key      = default_tenant_key

    super()
  end

  def perform(email, options, tenant_setting: nil)
    @email          = email
    @options        = options
    @tenant_setting = tenant_setting

    configure_smtp

    send_email
  end

  private

  def configure_smtp
    @smtp_settings.call
  end

  def plezi_headers
    {
      'Precedence'  => 'bulk',
      'Feedback-ID' => "TRANSACTIONAL:#{self.class::SG_CATEGORY}:plezi"
    }
  end

  def sender
    @options[:from].presence || 'no-reply@plezi.co'
  end

  def reply_to
    @options[:reply_to].present? ? { reply_to: @options[:reply_to] } : {}
  end

  def subject
    @options.has_key?(:subject) ? @options[:subject] : I18n.t(self.class::SG_SUBJECT)
  end

  def ga_enabled
    @ga_enabled ||= defined?(self.class::SG_ANALYTICS).present? && self.class::SG_ANALYTICS
  end

  def google_analytics
    {
      tracking_settings: {
        ganalytics:     { enable: ga_enabled },
        open_tracking:  { enable: ga_enabled },
        click_tracking: { enable: ga_enabled }
      }
    }
  end

  def substitutions
    {}
  end

  def custom_args
    {}
  end

  def personalizations
    [
      {
        to: [{ email: @email }]
      }.merge(substitutions)
    ]
  end

  def mail_params
    {
      from:             sender,
      subject:          subject,
      to:               @email,
      headers:          plezi_headers,
      categories:       [self.class::SG_CATEGORY],
      personalizations: personalizations
    }.merge(custom_args).merge(reply_to).merge(google_analytics)
  end

  def custom_layout
    @options[:plan].present? ? 'mailer_v2' : 'mailer'
  end

  def send_email
    mail(mail_params) do |format|
      format.text
      format.html(content_transfer_encoding: '7bit') { render layout: custom_layout }
    end
  end
end
