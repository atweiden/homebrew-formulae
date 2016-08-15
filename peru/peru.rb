require 'formula'

class Peru < Formula
  desc "A tool for including other people's code in your projects"
  homepage 'https://github.com/buildinspace/peru'
  url 'https://github.com/buildinspace/peru/archive/1.0.1.tar.gz'
  sha256 '7b606653f33b868b0544ada30a037f669ceb6425aeabbf1f9998f44c2f972eb4'

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
    url 'https://pypi.python.org/packages/75/5e/b84feba55e20f8da46ead76f14a3943c8cb722d40360702b2365b91dec00/PyYAML-3.11.tar.gz'
    sha256 'c36c938a872e5ff494938b33b14aaa156cb439ec67548fcab3535bb78b0846e8'
  end

  def install
    ENV["PYTHONPATH"] = lib+"python3.5/site-packages"
    ENV.prepend_create_path 'PYTHONPATH', libexec+'lib/python3.5/site-packages'
    ENV.prepend_create_path 'PYTHONPATH', prefix+'lib/python3.5/site-packages'
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
