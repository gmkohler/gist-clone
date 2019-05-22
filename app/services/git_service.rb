  GIST_DIRECTORY = Rails.root.join("gists", ENV["GIT_DIRECTORY"]).freeze
  TMP_DIRECTORY = Rails.root.join("tmp", ENV["GIT_DIRECTORY"]).freeze

  class << self
    def git_init(gist_id:)
      path = gist_directory(gist_id)

      system "mkdir -p #{path}"
      Dir.chdir(path) { system "git init" }

      path
    end

    def apply_diff(gist_id:, diff:)
      repo_directory = gist_directory(gist_id)
      patch_directory = tmp_directory(gist_id)

      patch_path = patch_directory.join("#{Digest::SHA256.hexdigest(diff)}.patch")

      `mkdir -p #{tmp_dir}`

      Dir.chdir(repo_directory) do
        `echo -n "#{diff}" > #{patch_path}`
        `git apply < #{patch_path}`
        `git add .`
        `git commit --allow-empty-message -m ''`
        `git rev-parse HEAD`.chomp
      end
    end

    private

    def gist_directory(gist_id)
      GIST_DIRECTORY.join(gist_id)
    end

    def tmp_directory(gist_id)
      TMP_DIRECTORY.join(gist_id)
    end
  end
end
