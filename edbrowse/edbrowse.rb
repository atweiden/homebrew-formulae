class Edbrowse < Formula
  desc "A command-line editor and web browser"
  homepage "http://www.edbrowse.org"
  url "https://github.com/CMB/edbrowse/archive/v3.8.2.1.tar.gz"
  sha256 "a9c1d1fd0665796b81f18b0556f80237c13594033062f9312a49aa9159086e7a"
  head "https://github.com/CMB/edbrowse.git"

  depends_on "curl"
  depends_on "duktape"
  depends_on "pcre"
  depends_on "readline"
  depends_on "tidy-html5"
  depends_on "cmake" => :build
  depends_on "perl" => :build
  depends_on "pkg-config" => :build

  def install
    mkdir("build") do
      system "cmake", *std_cmake_args, ".."
      system "make"
    end
    bin.install "build/edbrowse"
    man1.install "build/edbrowse.1.gz"
    doc.install "doc/sample.ebrc"
    doc.install "doc/usersguide.html"
  end

  test do
    (testpath/".ebrc").write <<~EOS
      function+init {
        # turn debug off, don't show status messages from this script
        db0
        # use readline for input
        rl+
      }
    EOS
    assert_match "3.8.2.1", shell_output("#{bin}/edbrowse -v")
  end
end
