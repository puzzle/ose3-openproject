#-- copyright
# OpenProject is a project management system.
# Copyright (C) 2012-2017 the OpenProject Foundation (OPF)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License version 3.
#
# OpenProject is a fork of ChiliProject, which is a fork of Redmine. The copyright follows:
# Copyright (C) 2006-2017 Jean-Philippe Lang
# Copyright (C) 2010-2013 the ChiliProject Team
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
# See doc/COPYRIGHT.rdoc for more details.
#++

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :openid_connect,
  name: ENV['RAILS_OMNIAUTH_PROVIDER'],
  scope: [:openid, :email, :profile],
  response_type: :code,
  client_options: {
    port: ENV['RAILS_OMNIAUTH_PORT'],
    scheme: ENV['RAILS_OMNIAUTH_SCHEME'],
    host: ENV['RAILS_OMNIAUTH_HOST'],
    identifier: ENV["RAILS_OMNIAUTH_CLIENT_ID"],
    display_name: ENV["RAILS_OMNIAUTH_DISPLAY_NAME"],
    secret: ENV["RAILS_OMNIAUTH_SECRET_KEY"],
    redirect_uri: ENV["RAILS_OMNIAUTH_REDIRECT_URI"],
    authorization_endpoint: ENV['RAILS_OMNIAUTH_AUTHORIZATION_ENDPOINT'],
    token_endpoint: ENV['RAILS_OMNIAUTH_TOKEN_ENDPOINT'],
    userinfo_endpoint: ENV['RAILS_OMNIAUTH_USERINFO_ENDPOINT'],
    sso: ENV['RAILS_OMNIAUTH_SSO'],
    issuer: ENV['RAILS_OMNIAUTH_ISSUER'],
    end_session_endpoint: ENV['RAILS_OMNIAUTH_END_SESSION_ENDPOINT'],
    check_session_iframe: ENV['RAILS_OMNIAUTH_CHECK_SESSION_IFRAME'],
  }
end
