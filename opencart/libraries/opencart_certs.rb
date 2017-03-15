require 'rubygems'
require 'openssl'
require 'chef/resource'
require 'fileutils'

module OpenCartHelper
class Certificates < Chef::Resource

  # Create self-signed certificate
  def initialize(cert_file, key_file, ca_cert_file)

    #unless ::File.exist(ca_cert_file)
      ssl_key = ::OpenSSL::PKey::RSA.new 2048
      public_key = ssl_key.public_key

      subject = "/C=BE/O=Test/OU=Test/CN=Test"

      # Root certificate
      root_key = OpenSSL::PKey::RSA.new 2048 # the CA's public/private key
      root_ca = OpenSSL::X509::Certificate.new
      root_ca.version = 2 # cf. RFC 5280 - to make it a "v3" certificate
      root_ca.serial = 1
      root_ca.subject = OpenSSL::X509::Name.parse subject
      root_ca.issuer = root_ca.subject # root CA's are "self-signed"
      root_ca.public_key = root_key.public_key
      root_ca.not_before = Time.now
      root_ca.not_after = root_ca.not_before + 2 * 365 * 24 * 60 * 60 # 2 years validity
      ef = OpenSSL::X509::ExtensionFactory.new
      ef.subject_certificate = root_ca
      ef.issuer_certificate = root_ca
      root_ca.add_extension(ef.create_extension("basicConstraints","CA:TRUE",true))
      root_ca.add_extension(ef.create_extension("keyUsage","keyCertSign, cRLSign", true))
      root_ca.add_extension(ef.create_extension("subjectKeyIdentifier","hash",false))
      root_ca.add_extension(ef.create_extension("authorityKeyIdentifier","keyid:always",false))
      root_ca.sign(root_key, OpenSSL::Digest::SHA256.new)

      d = ::File.dirname(ca_cert_file)
      ::FileUtils.mkdir_p(d) unless ::Dir.exist?(d)
      ::File.open(ca_cert_file, "wb") { |f| f.print root_ca.to_der }
    #end

    #unless ::File.exist(key_file) || !::File.exist(cert_file)
      # Certificate
      cert_ssl_key = OpenSSL::PKey::RSA.new 2048
      cert = OpenSSL::X509::Certificate.new
      cert.version = 2
      cert.serial = 2
      cert.subject = OpenSSL::X509::Name.parse subject
      cert.issuer = root_ca.subject # root CA is the issuer
      cert.public_key = cert_ssl_key.public_key
      cert.not_before = Time.now
      cert.not_after = cert.not_before + 1 * 365 * 24 * 60 * 60 # 1 years validity
      ef = OpenSSL::X509::ExtensionFactory.new
      ef.subject_certificate = cert
      ef.issuer_certificate = root_ca
      cert.add_extension(ef.create_extension("keyUsage","digitalSignature", true))
      cert.add_extension(ef.create_extension("subjectKeyIdentifier","hash",false))
      cert.sign(root_key, OpenSSL::Digest::SHA256.new)

      [ cert_file, key_file ].each do |f|
        d = ::File.dirname(f)
        FileUtils.mkdir_p(d) unless ::Dir.exist?(d)
      end

      ::File.open(key_file, "wb")     { |f| f.print cert_ssl_key.to_der }
      ::File.open(cert_file, "wb")    { |f| f.print cert.to_der }
    #end
  end
end
end
