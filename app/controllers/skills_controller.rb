class SkillsController < ApplicationController
	
	def index
		@skills = Skill.all
		navigation_add("Skill Index", "#")
	end

	def new
		@skill = Skill.new
		navigation_add("Skill Index", skills_path)
		navigation_add("New Skill", "#")
	end

	def create
		@skill = Skill.new(skill_params)
		if @skill.valid?
			@skill.save
			redirect_to @skill
		else
			render 'new'
		end
	end

	def edit
		@skill = Skill.find(params[:id])	
		navigation_add("Skill Index", skills_path)
		navigation_add("Skill Show", @skill)
		navigation_add("Edit Skill", "#")
	end

	def update
		@skill = Skill.find(params[:id])
		@skill.update(skill_params)
		if @skill.valid?
			@skill.save
			redirect_to @skill
		else
			render 'edit'
		end
	end

	def show
		@skill = Skill.find(params[:id])
		navigation_add("Skill Index", skills_path)
		navigation_add("Skill Show", "#")
	end

	def destroy
		@skill = Skill.find(params[:id])
		name = @skill.name
		@skill.destroy
		flash[:notice] = "#{name} removed."
		redirect_to skills_path
	end

	private
	def skill_params
		params.require(:skill).permit(
			:name,
			:power,
			:max_pp,
			:element_type
			)
	end

end
