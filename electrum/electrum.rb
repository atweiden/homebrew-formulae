require 'formula'

class Electrum < Formula
  desc 'Lightweight Bitcoin wallet'
  homepage 'https://electrum.org'
  url 'https://download.electrum.org/2.6.4/Electrum-2.6.4.tar.gz'
  sha256 '2ab53b434206ed8ae72e9cadb22d44ef9ba720a7d052abe102f5d55cafbef866'

  head do
    url "https://github.com/spesmilo/electrum.git"
  end

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on 'curl'    => :build
  depends_on 'gettext' => :build
  depends_on 'gmp'
  depends_on 'pillow'
  depends_on 'protobuf'
  depends_on 'pyqt'
  depends_on 'qt'
  depends_on 'zbar' => :optional

  resource 'chardet' do
    url 'https://pypi.python.org/packages/7d/87/4e3a3f38b2f5c578ce44f8dc2aa053217de9f0b6d737739b0ddac38ed237/chardet-2.3.0.tar.gz'
    sha256 'e53e38b3a4afe6d1132de62b7400a4ac363452dc5dfcf8d88e8e0cce663c68aa'
  end

  resource 'dnspython' do
    url 'https://pypi.python.org/packages/e1/ab/36f4e337d6cf6590f9cf46349f519b682542d211c604755ab8409f67f26b/dnspython-1.14.0.zip'
    sha256 '21458b942637578f238c7029dc0512c75e61ef64ee0de82a62d175e89d2131dc'
  end

  resource 'ecdsa' do
    url 'https://pypi.python.org/packages/f9/e5/99ebb176e47f150ac115ffeda5fedb6a3dbb3c00c74a59fd84ddf12f5857/ecdsa-0.13.tar.gz'
    sha256 '64cf1ee26d1cde3c73c6d7d107f835fed7c6a2904aef9eac223d57ad800c43fa'
  end

  resource 'jsonrpclib' do
    url 'https://pypi.python.org/packages/a9/0a/69b6b794d7b086793683743df2f6d0a4fcf97613a95a39cfc74b78f2adb7/jsonrpclib-0.1.7.tar.gz'
    sha256 '7f50239d53b5e95b94455d5e1adae70592b5b71f0e960d3bbbfbb125788e6f0b'
  end

  resource 'pbkdf2' do
    url 'https://pypi.python.org/packages/02/c0/6a2376ae81beb82eda645a091684c0b0becb86b972def7849ea9066e3d5e/pbkdf2-1.3.tar.gz'
    sha256 'ac6397369f128212c43064a2b4878038dab78dab41875364554aaf2a684e6979'
  end

  resource 'protobuf' do
    url 'https://pypi.python.org/packages/14/3e/56da1ecfa58f6da0053a523444dff9dfb8a18928c186ad529a24b0e82dec/protobuf-3.0.0.tar.gz'
    sha256 'ecc40bc30f1183b418fe0ec0c90bc3b53fa1707c4205ee278c6b90479e5b6ff5'
  end

  resource 'pycrypto' do
    url 'https://pypi.python.org/packages/60/db/645aa9af249f059cc3a368b118de33889219e0362141e75d4eaf6f80f163/pycrypto-2.6.1.tar.gz'
    sha256 'f2ce1e989b272cfcb677616763e0a2e7ec659effa67a88aa92b3a65528f60a3c'
  end

  resource 'pycurl' do
    url 'https://pypi.python.org/packages/12/3f/557356b60d8e59a1cce62ffc07ecc03e4f8a202c86adae34d895826281fb/pycurl-7.43.0.tar.gz'
    sha256 'aa975c19b79b6aa6c0518c0cc2ae33528900478f0b500531dbcdbf05beec584c'
  end

  resource 'qrcode' do
    url 'https://pypi.python.org/packages/87/16/99038537dc58c87b136779c0e06d46887ff5104eb8c64989aac1ec8cba81/qrcode-5.3.tar.gz'
    sha256 '4115ccee832620df16b659d4653568331015c718a754855caf5930805d76924e'
  end

  resource 'requests' do
    url 'https://pypi.python.org/packages/8d/66/649f861f980c0a168dd4cccc4dd0ed8fa5bd6c1bed3bea9a286434632771/requests-2.11.0.tar.gz'
    sha256 'b2ff053e93ef11ea08b0e596a1618487c4e4c5f1006d7a1706e3671c57dea385'
  end

  resource 'six' do
    url 'https://pypi.python.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz'
    sha256 '105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a'
  end

  resource 'slowaes' do
    url 'https://pypi.python.org/packages/79/a4/c7dcbe89ec22a6985790bc0effb12bb8caef494fbac3c2bab86ae51a53ef/slowaes-0.1a1.tar.gz'
    sha256 '83658ae54cc116b96f7fdb12fdd0efac3a4e8c7c7064e3fac3f4a881aa54bf09'
  end

  resource 'urllib3' do
    url 'https://pypi.python.org/packages/3b/f0/e763169124e3f5db0926bc3dbfcd580a105f9ca44cf5d8e6c7a803c9f6b5/urllib3-1.16.tar.gz'
    sha256 '63d479478ddfc83bbc11577dc16d47835c5179ac13e550118ca143b62c4bf9ab'
  end

  def install
    ENV["PYTHONPATH"] = lib+"python2.7/site-packages"
    ENV.prepend_create_path 'PYTHONPATH', libexec+'lib/python2.7/site-packages'
    ENV.prepend_create_path 'PYTHONPATH', prefix+'lib/python2.7/site-packages'
    install_args = [
      "setup.py",
      "install",
      "--prefix=#{libexec}",
      "--optimize=1"
    ]

    res = %w[
      chardet
      dnspython
      ecdsa
      jsonrpclib
      pbkdf2
      protobuf
      pycrypto
      pycurl
      qrcode
      requests
      six
      slowaes
      urllib3
    ]
    res.each do |r|
      resource(r).stage { system "python", *install_args }
    end

    if build.head? do
      system "pyrcc4", "icons.qrc", "-o", "gui/qt/icons_rc.py"
      system "protoc", "--proto_path=lib/", "--python_out=lib/", "lib/paymentrequest.proto"
      system "python", "contrib/make_locale"
    end
    system "python", "setup.py", "build"
    system "python", "setup.py", "install", "--prefix=#{prefix}", "--optimize=1"

    bin.env_script_all_files(libexec+'bin', :PYTHONPATH => ENV['PYTHONPATH'])
  end

  test do
    system "#{bin}/electrum", "verifymessage", "1BwgQYh84KRX1anw6ptUyxGFUTQEtr2PxB", "G3I+Pimnb2YI7xN1oEAkD2PQCjG23wo//TVbgaAwPr4tbhTF8gUARGTVmfOqfEHGs5M785j4Kl3p7zyXFsBLa90=", "\"The Times 03/Jan/2009 Chancellor on brink of second bailout for banks\""
  end
end
