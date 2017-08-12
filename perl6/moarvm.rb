require "FileUtils"
class Moarvm < Formula
  desc "6model-based VM for NQP and Rakudo Perl6"
  homepage "https://github.com/MoarVM/MoarVM"
  url "https://codeload.github.com/MoarVM/MoarVM/tar.gz/2017.07"
  sha256 "3c6b7e6eb817efb36d502bc2fbf95cc6ce8532bc710d22831fde613a4c4dbf8d"

  head do
    url "https://github.com/MoarVM/MoarVM.git"
  end

  depends_on "llvm"
  depends_on "git" => :build
  depends_on "make" => :build
  depends_on "perl" => :build
  depends_on "pkg-config" => :build

  def install
    # get lib deps
    ["dynasm", "dyncall", "libtommath"].each do |submodule|
      system "git", "clone", "https://github.com/MoarVM/#{submodule}"
      FileUtils.rm_rf "3rdparty/#{submodule}"
      FileUtils.mv submodule, "3rdparty"
    end
    ["libuv"].each do |submodule|
      system "git", "clone", "https://github.com/libuv/#{submodule}"
      FileUtils.rm_rf "3rdparty/#{submodule}"
      FileUtils.mv submodule, "3rdparty"
    end

    system "perl", "Configure.pl", "--prefix=#{prefix}", "--optimize"
    system "make"
    system "make", "install"
  end

  test do
    system "#{bin}/moar", "--version"
  end
end
