class Edbrowse < Formula
  desc "A command-line editor and web browser"
  homepage "http://www.edbrowse.org"
  url "https://github.com/CMB/edbrowse/archive/v3.7.4.tar.gz"
  sha256 "b79e6417c1170c96ef68968c33d585725f0f2d27859e3fe807c980a9c33ea719"
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
    assert_match "3.7.4", shell_output("#{bin}/edbrowse -v")
  end
end
