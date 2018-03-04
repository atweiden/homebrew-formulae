require 'formula'

class Peru < Formula
  desc "A tool for including other people's code in your projects"
  homepage 'https://github.com/buildinspace/peru'
  url 'https://github.com/buildinspace/peru/archive/1.1.3.tar.gz'
  sha256 'b3665f4d496acdac1ef0a12fb8b664c8ab223198c532ab7650b0dd2c5b146cef'

  depends_on 'git'
  depends_on 'libyaml'
  depends_on 'python3'
  depends_on 'mercurial' => :optional
  depends_on 'subversion' => :optional

  resource 'docopt' do
    url 'https://pypi.python.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz'
    sha256 '49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491'
  end

  resource 'yaml' do
    url 'https://pypi.python.org/packages/4a/85/db5a2df477072b2902b0eb892feb37d88ac635d36245a72a6a69b23b383a/PyYAML-3.12.tar.gz'
    sha256 '592766c6303207a20efc445587778322d7f73b161bd994f227adaa341ba212ab'
  end

  def install
    ENV["PYTHONPATH"] = lib+"python3.6/site-packages"
    ENV.prepend_create_path 'PYTHONPATH', libexec+'lib/python3.6/site-packages'
    ENV.prepend_create_path 'PYTHONPATH', prefix+'lib/python3.6/site-packages'
    install_args = [
      "setup.py",
      "install",
      "--prefix=#{libexec}",
      "--optimize=1"
    ]

    res = %w[docopt yaml]
    res.each do |r|
      resource(r).stage { system "python3", *install_args }
    end

    system "python3", "setup.py", "build"
    system "python3", "setup.py", "install", "--prefix=#{prefix}", "--optimize=1"

    bin.env_script_all_files(libexec+'bin', :PYTHONPATH => ENV['PYTHONPATH'])
  end

  test do
    system "#{bin}/peru", "--version"
  end
end
