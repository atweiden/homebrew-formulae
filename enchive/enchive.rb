class Enchive < Formula
  desc "Encrypted personal archives"
  homepage "https://github.com/skeeto/enchive"
  url "https://github.com/skeeto/enchive/releases/download/3.4/enchive-3.4.tar.xz"
  sha256 "1e8551df0bb98a4f20930a010b3a6b01f60078af86288370ef93895a3918505e"
  head "https://github.com/skeeto/enchive.git"

  depends_on "make" => :build

  def install
    ENV.append "CFLAGS", "-ansi -pedantic -Wall -Wextra -O3 -g3"
    ENV.append "CFLAGS", "-D_FILE_OFFSET_BITS=64"
    ENV.append "CFLAGS", "-DENCHIVE_AGENT_TIMEOUT=420"
    ENV.append "CFLAGS", "-DENCHIVE_FILE_EXTENSION='.enc'"
    inreplace "Makefile" do |s|
      s.change_make_var! "CFLAGS", ENV['CFLAGS']
    end
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    true
  end
end
