<?php
/**
 * @file
 * Enables modules and site configuration for a standard site installation.
 */

/**
 * Implements hook_form_FORM_ID_alter() for install_configure_form().
 *
 * Allows the profile to alter the site configuration form.
 */
function teampulse_form_install_configure_form_alter(&$form, $form_state) {
  // Pre-populate the site name with the server name.
  $form['site_information']['site_name']['#default_value'] = 'TeamPulse';
}


function teampulse_install_tasks(){
  $tasks = array();
  $tasks['teampulse_add_terms'] = array(

      'display_name' => st('Add Taxonomy Terms'),

      'display' => TRUE,

      'type' => 'batch',

     );
  return $tasks;
}


function teampulse_add_terms(){
$vocabulary =  taxonomy_vocabulary_machine_name_load('departments'); 
if($vocabulary){
$vid = $vocabulary->vid;
drupal_set_message('got the vid');
drupal_set_message($vid);
}
else{
$vid = 2;
drupal_set_message('did not get the vid');
}
	$terms = array('Admin','Sales', 'Human Resource');
//          print_r($terms);
          
           foreach ($terms as $term) {
             drupal_set_message('starting terms add function');
 	$newterm = new stdClass();
  	$newterm->name = $term; // The name of the term
  	$newterm->vid = $vid; // The ID of the parent vocabulary
  	$newterm->parent = 0; // This tells taxonomy that this is a top-level term
    taxonomy_term_save($newterm);

		  }
         
}