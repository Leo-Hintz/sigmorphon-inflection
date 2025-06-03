while getopts "p:c:" opt; do
    case $opt in
        p) project_path=$OPTARG;;
        c) config_path=$OPTARG;;
        *) echo "USAGE: $0 -c <config_path> -p <project_path>"
            exit 1;;
    esac
done
conda_path=$(jq -r '.conda_path' "$project_path/$config_path")
source "$conda_path/etc/profile.d/conda.sh"
conda activate inflection
python $project_path/train_models.py -c config.json -p $project_path
