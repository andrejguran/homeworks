require "fileutils"
class JavaChecker

  def self.check
    return "checkujem javu"
  end

  def self.compilable? work
    new_file_dir = File.join(Rails.application.config.upload_dir, "homework/src", work.user.uco.to_s, work.id.to_s, work.task.package.tr(".", "/"))
    new_file_path = File.join(new_file_dir, work.homework_file_name)
    FileUtils.mkdir_p(File.dirname(new_file_path))
    FileUtils.cp work.homework.path, new_file_path

    command = "javac " + new_file_path
    response = system(command)

    return response
  end

  def self.destroy work
    work_dir = File.join(Rails.application.config.upload_dir, "homework/src", work.user.uco.to_s, work.id.to_s)
    FileUtils.rm_rf(work_dir)
  end

  def self.generate work
    require "fileutils"
    classes_path = File.join(Rails.application.config.upload_dir, "homework/classes", work.user.uco.to_s, work.id.to_s)

    include_class_path = "-cp " + classes_path + ":" + Rails.root.to_s + "/lib/assets/junit.jar" + ":" + Rails.root.to_s + "/lib/assets/hamcrest-core.jar "
    command_run_test = "java " + include_class_path  + "org.junit.runner.JUnitCore " + work.task.package + "." + File.basename(work.task.task_file_file_name, ".*")

    response_run_test = `#{command_run_test}`

    return CodeRay.scan(response_run_test.encode('utf-8'), :java).div
  end

  def self.compile work
    classes_path = File.join(Rails.application.config.upload_dir, "homework/classes", work.user.uco.to_s, work.id.to_s)
    FileUtils.mkdir_p(classes_path)

    junit_path = File.join(Rails.root, "lib/assets/junit.jar")
    new_file_dir = File.join(Rails.application.config.upload_dir, "homework/src", work.user.uco.to_s, work.id.to_s, work.task.package.tr(".", "/"))
    work_file_path = File.join(new_file_dir, work.homework_file_name)
    test_file_path = File.join(Rails.application.config.upload_dir, "homework/src/tests", work.task.id.to_s, work.task.package.tr(".", "/"), File.basename(work.task.task_file_file_name, ".*")) + ".java"
    command_compile_src_and_test = "javac" + " -encoding UTF-8 " + "-cp " + junit_path + " -d " + classes_path +" " + work_file_path + " " + test_file_path
    response_compile_src_and_test = `#{command_compile_src_and_test}`

    test_files = File.join(Rails.application.config.upload_dir, "homework/src/tests", work.task.id.to_s, work.task.package.tr(".", "/")) + "/*"
    FileUtils.cp_r Dir.glob(test_files), File.join(classes_path, work.task.package.tr(".", "/"))

    include_class_path = "-cp " + classes_path + ":" + Rails.root.to_s + "/lib/assets/junit.jar" + ":" + Rails.root.to_s + "/lib/assets/hamcrest-core.jar "
    command_run_test = "java " + include_class_path  + "org.junit.runner.JUnitCore " + work.task.package + "." + work.task.task_file_file_name[0..-6]
    response_run_test = `#{command_run_test}`

    if response_run_test.include? "FAILURES!" or response_run_test.include? "Could not find class"
      work.status = "fail"
    elsif response_run_test.include? "OK"
      work.status = "success"
    end
  end

end
