<script>
  //imports
  import { onMount } from 'svelte'
  import { newQuestion, edit, draft } from '../UrbitStore'

  // Main Area
  import NewQuestion from './NewQuestion.svelte'
  import SurveyHeader from './SurveyHeader.svelte'

  // Display Questions
  import QContainer from '../QuestionsEdit/QContainer.svelte'
  import QPContainer from '../QuestionsPub/QPContainer.svelte'

  // Defining things
  export let survey;
    let isAdmin;
    let droft;

  onMount(()=> {
    edit.subscribe(res => isAdmin = res)
    draft.subscribe(res => droft = res)
  })

</script>

<div class="container">
  {#if survey}
    <SurveyHeader
      title={survey[0].title}
      description={survey[0].description}
      author={survey[0].author}
      slug={survey[0].slug}
    />
    {#if survey[1]}
      {#each survey[1] as qs}
        {#if isAdmin}
          <QContainer qs={qs} />
        {:else}
          <QPContainer qs={qs} sid={survey[0].id}/>
        {/if}
      {/each}
    {:else}
      <p>No questions yet!</p>
    {/if}
    {#if isAdmin}
      <NewQuestion sid={survey[0].id}/>
    {/if}
  {/if}
</div>

<style>

  .container {
    width: 80%;
    margin: auto;
  }

</style>
