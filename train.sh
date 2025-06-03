while getopts "p:" opt; do
    case $opt in
        p) project_path=$OPTARG;;
        *) echo "USAGE: $0 -c <config_path> -p <project_path>"
            exit 1;;
    esac
done


conda run -n inflection python "$project_path/train_models.py" -c "config.json" -p $project_path