require 'formula'

class Electrum < Formula
  desc 'Lightweight Bitcoin wallet'
  homepage 'https://electrum.org'
  url 'https://download.electrum.org/2.7.18/Electrum-2.7.18.tar.gz'
  sha256 '2ab53b434206ed8ae72e9cadb22d44ef9ba720a7d052abe102f5d55cafbef866'

  head do
    url "https://github.com/spesmilo/electrum.git"
  end

  depends_on :python if MacOS.version <= :snow_leopard
  depends_on 'curl'    => :build if build.head?
  depends_on 'gettext' => :build if build.head?
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
    url 'https://pypi.python.org/packages/e4/96/a598fa35f8a625bc39fed50cdbe3fd8a52ef215ef8475c17cabade6656cb/dnspython-1.15.0.zip'
    sha256 '40f563e1f7a7b80dc5a4e76ad75c23da53d62f1e15e6e517293b04e1f84ead7c'
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
    url 'https://pypi.python.org/packages/e0/2f/690a5f047e2cfef40c9c5eec0877b496dc1f5a0625ca6b0ac1cd11f12f6a/protobuf-3.2.0.tar.gz'
    sha256 'a48475035c42d13284fd7bf3a2ffa193f8c472ad1e8539c8444ea7e2d25823a1'
  end

  resource 'PySocks' do
    url 'https://pypi.python.org/packages/fd/70/ba9982cedc9b3ed3c06934f1f46a609e0f23c7bfdf567c52a09f1296b8cb/PySocks-1.6.6.tar.gz'
    sha256 '02419a225ff5dcfc3c9695ef8fc9b4d8cc99658e650c6d4718d4c8f451e63f41'
  end

  resource 'pyaes' do
    url 'https://pypi.python.org/packages/63/31/6768a72cdca5dbd299ae798b690801e6c9c2f018332eec3c5fca79370dba/pyaes-1.6.0.tar.gz'
    sha256 '9cd5a54d914b1eebfb14fcb490315214b6a0304d9f1bb47e90d1d8e0b15ce92e'
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
    url 'https://pypi.python.org/packages/16/09/37b69de7c924d318e51ece1c4ceb679bf93be9d05973bb30c35babd596e2/requests-2.13.0.tar.gz'
    sha256 '5722cd09762faa01276230270ff16af7acf7c5c45d623868d9ba116f15791ce8'
  end

  resource 'six' do
    url 'https://pypi.python.org/packages/b3/b2/238e2590826bfdd113244a40d9d3eb26918bd798fc187e2360a8367068db/six-1.10.0.tar.gz'
    sha256 '105f8d68616f8248e24bf0e9372ef04d3cc10104f1980f54d57b2ce73a5ad56a'
  end

  resource 'urllib3' do
    url 'https://pypi.python.org/packages/20/56/a6aa403b0998f857b474a538343ee483f5c02491bd1aebf61d42a3f60f77/urllib3-1.20.tar.gz'
    sha256 '97ef2b6e2878d84c0126b9f4e608e37a951ca7848e4855a7f7f4437d5c34a72f'
  end

  def install
    ENV["PYTHONPATH"] = lib+"python2.7/site-packages"
    ENV.prepend_create_path 'PYTHONPATH', libexec+'lib/python2.7/site-packages'
    ENV.prepend_create_path 'PYTHONPATH', prefix+'lib/python2.7/site-packages'
    # for homebrew curl built with homebrew `--with-openssl` option
    ENV.append "LDFLAGS", "-L/usr/local/opt/openssl/lib"
    ENV.append "CPPFLAGS", "-I/usr/local/opt/openssl/include"
    ENV.append "PKG_CONFIG_PATH", "/usr/local/opt/openssl/lib/pkgconfig"

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
      PySocks
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

    if build.head?
      system "pyrcc4", "icons.qrc", "-o", "gui/qt/icons_rc.py"
      system "protoc", "--proto_path=lib/", "--python_out=lib/", "lib/paymentrequest.proto"
      system "python", "contrib/make_locale"
    end
    system "python", "setup.py", "build"
    system "python", "setup.py", "install", "--prefix=#{prefix}", "--optimize=1"

    # fix linking conflicts
    rm Dir["#{bin}/easy_install*"]

    bin.env_script_all_files(libexec+'bin', :PYTHONPATH => ENV['PYTHONPATH'])
  end

  test do
    system "#{bin}/electrum", "verifymessage", "1BwgQYh84KRX1anw6ptUyxGFUTQEtr2PxB", "G3I+Pimnb2YI7xN1oEAkD2PQCjG23wo//TVbgaAwPr4tbhTF8gUARGTVmfOqfEHGs5M785j4Kl3p7zyXFsBLa90=", "\"The Times 03/Jan/2009 Chancellor on brink of second bailout for banks\""
  end
end
