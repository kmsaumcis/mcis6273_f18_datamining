syllabus:
	cd /mnt/c/Users/Keith/Code/PycharmProjects/mcis6273_f17_datamining_PVT/syllabus; python3 ./generate.py
	cd ~/_mcis6273_f17_hugo
	cp /mnt/c/Users/Keith/Code/PycharmProjects/mcis6273_f17_datamining_PVT/syllabus/syllabus.md ./content 
	pandoc ./content/syllabus.md -o ./tmp/syllabus.html
	pandoc -V geometry:margin=.75in ./tmp/syllabus.html -o ./content/syllabus.pdf
	cp ./content/syllabus.pdf /mnt/c/Users/Keith/Desktop
#	rm -Rf ./tmp

homework:
	cd /mnt/c/Users/Keith/Code/PycharmProjects/mcis6273_f17_datamining_PVT/homework/$(HW); python3 ../generate_hw.py --i $(HW).yaml --o $(HW).ipynb --tnb ../hw_ipynb_template.ipynb --tmd ../hw_template_md 
	cd -    
	cp /mnt/c/Users/Keith/Code/PycharmProjects/mcis6273_f17_datamining_PVT/homework/$(HW)/$(HW).ipynb ./content/homework
	jupyter nbconvert /mnt/c/Users/Keith/Code/PycharmProjects/mcis6273_f17_datamining_PVT/homework/$(HW)/$(HW).ipynb --to markdown --output-dir=./content/homework
	pandoc -V geometry:margin=1in ./content/homework/$(HW).md -o ./content/homework/$(HW).pdf
	cp ./content/homework/$(HW).pdf /mnt/c/Users/Keith/Desktop
	cp ./content/homework/$(HW).md /mnt/c/Users/Keith/Code/PycharmProjects/mcis6273_f17_datamining_PVT/homework/$(HW)

solution:
	cp /mnt/c/Users/Keith/Code/PycharmProjects/mcis6273_f17_datamining_PVT/homework/$(HW)/$(HW)_soln_master.ipynb ./content/homework
	jupyter nbconvert /mnt/c/Users/Keith/Code/PycharmProjects/mcis6273_f17_datamining_PVT/homework/$(HW)/$(HW)_soln_master.ipynb --to markdown --output-dir=./content/homework
	pandoc -V geometry:margin=1in ./content/homework/$(HW)_soln_master.md -o ./content/homework/$(HW)_soln_master.pdf
	cp ./content/homework/$(HW)_soln_master.pdf /mnt/c/Users/Keith/Desktop
	cp ./content/homework/$(HW)_soln_master.md /mnt/c/Users/Keith/Code/PycharmProjects/mcis6273_f17_datamining_PVT/homework/$(HW)
        

make update:
	echo "Deleting old publication"
	rm -rf public
	mkdir public
	git worktree prune
	rm -rf .git/worktrees/public/

	echo "Checking out gh-pages branch into public"
	git worktree add -B gh-pages public upstream/gh-pages

	echo "Removing existing files"
	rm -rf public/*

	echo "Generating site"
	hugo

	echo "Updating gh-pages branch"
	cd public && git add --all && git commit -m "Publishing to gh-pages (publish.sh)"
	

