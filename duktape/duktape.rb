class Duktape < Formula
  desc "Embeddable Javascript engine with compact footprint"
  homepage "https://duktape.org"
  url "https://duktape.org/duktape-2.7.0.tar.xz"
  sha256 "90f8d2fa8b5567c6899830ddef2c03f3c27960b11aca222fa17aa7ac613c2890"
  license "MIT"

  def install
    ENV["INSTALL_PREFIX"] = prefix
    system "make", "-f", "Makefile.sharedlibrary", "install"
    system "make", "-f", "Makefile.cmdline"
    bin.install "duk"
  end

  test do
    (testpath/"test.js").write "console.log('Hello Homebrew!');"
    assert_equal "Hello Homebrew!", shell_output("#{bin}/duk test.js").strip

    (testpath/"test.cc").write <<~EOS
      #include <stdio.h>
      #include "duktape.h"
      int main(int argc, char *argv[]) {
        duk_context *ctx = duk_create_heap_default();
        duk_eval_string(ctx, "1 + 2");
        printf("1 + 2 = %d\\n", (int) duk_get_int(ctx, -1));
        duk_destroy_heap(ctx);
        return 0;
      }
    EOS
    system ENV.cc, "test.cc", "-o", "test", "-I#{include}", "-L#{lib}", "-lduktape", "-lm"
    assert_equal "1 + 2 = 3", shell_output("./test").strip, "Duktape can add number"
  end
end
