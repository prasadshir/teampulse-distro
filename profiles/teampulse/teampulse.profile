<?php

/**
 * @file
 * Enables modules and site configuration for the Teampulse distribution.
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

/**
 * Implements hook_install_tasks().
 */
function teampulse_install_tasks() {
  $tasks = array();
  $tasks['teampulse_add_terms'] = array(
    'display_name' => st('Add Taxonomy Terms'),
    'display' => TRUE,
    'type' => 'batch',
  );
  return $tasks;
}


/**
 * Install task; Adds some terms to the Departments vocabulary.
 */
function teampulse_add_terms() {
  $vocabulary = taxonomy_vocabulary_machine_name_load('departments');
  if ($vocabulary) {
    $vid = $vocabulary->vid;
    drupal_set_message('got the vid');
    drupal_set_message($vid);
  }
  else {
    $vid = 2;
    drupal_set_message('did not get the vid');
  }

  $terms = array('Admin', 'Sales', 'Human Resource');

  foreach ($terms as $term) {
    drupal_set_message('starting terms add function');
    $newterm = new stdClass();
    // The name of the term.
    $newterm->name = $term;
    // The ID of the parent vocabulary.
    $newterm->vid = $vid;
    // This tells taxonomy that this is a top-level term.
    $newterm->parent = 0;
    taxonomy_term_save($newterm);
  }
}
