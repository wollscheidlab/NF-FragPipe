//////////////////////////
// Workflow definitions //
//////////////////////////


include {fragpipeSearch} from './fragpipe_processes.nf'


workflow search{
    take:
    tools_folder_fp
    diann_fp
    python_fp
    workflow_fp
    manifest_fp
    raw_files
    database_fp
    fragpipe_threads
	
    main:

    fragpipeSearch(tools_folder_fp,
		   diann_fp,
		   python_fp,
		   workflow_fp,
		   manifest_fp,
		   raw_files,
		   database_fp,
		   fragpipe_threads)
}

