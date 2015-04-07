namespace :cleanup do

  task :remove_memberships => :environment do
    memberships = Membership.all
    memberships.each do |mem|
      if mem.user_id == nil || mem.project_id == nil
        mem.destroy
      end
    end
  end

  task :remove_tasks_by_project => :environment do
    tasks = Task.all
    tasks.each do |task|
      if task.project_id == nil
        task.destroy
      end
    end
  end

  task :remove_comments_by_tasks => :environment do
    comments = Comment.all
    comments.each do |com|
      if com.task_id == nil
        com.destroy
      end
    end
  end
end
