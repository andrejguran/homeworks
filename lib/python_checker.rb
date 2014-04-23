class PythonChecker < Checker

  def self.compilable? work
    new_file_dir = File.join(Rails.application.config.upload_dir, "homework/src", work.user.uco.to_s, work.id.to_s, work.task.package)
    new_file_path = File.join(new_file_dir, work.homework_file_name)
    FileUtils.mkdir_p(File.dirname(new_file_path))
    FileUtils.cp work.homework.path, new_file_path

    command = "python " + new_file_path
    response = system(command)

    return response
  end

  def self.generate work
    work_dir = File.join(Rails.application.config.upload_dir, "homework/src", work.user.uco.to_s, work.id.to_s, work.task.package)
    command_run_test = "python " + work_dir + "/" + work.task.package + ".py"

    stdout, output, status = Open3.capture3(command_run_test)

    return CodeRay.scan(output.encode('utf-8'), :python).div
  end

  def self.compile work
    work_dir = File.join(Rails.application.config.upload_dir, "homework/src", work.user.uco.to_s, work.id.to_s, work.task.package)
    test_files = File.join(Rails.application.config.upload_dir, "homework/src/tests", work.task.id.to_s, work.task.package) + "/*"
    FileUtils.cp_r Dir.glob(test_files), work_dir

    command_run_test = "python " + work_dir + "/" + work.task.package + ".py"
    response = system(command_run_test)

    if response
      work.status = "success"
    else
      work.status = "fail"
    end
  end

end
