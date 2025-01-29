//////////////////////////
// Workflow definitions //
//////////////////////////


include {fragpipeSearch} from './fragpipe_processes.nf'


workflow search{
    take:
    workflow_fp
    manifest_fp
    raw_files
    database_fp
    fragpipe_threads
	
    main:

    fragpipeSearch(workflow_fp,
		   manifest_fp,
		   raw_files,
		   database_fp,
		   fragpipe_threads)
}

