<script>
  //imports
  import { onMount } from 'svelte'
  import { newQuestion, edit } from '../UrbitStore'
  import QContainer from '../QuestionsEdit/QContainer.svelte'
  import Above from '../questions/Above.svelte'
  import NewQuestion from '../questions/NewQuestion.svelte'
  import SurveyHeader from './SurveyHeader.svelte'
 
  export let survey;
  let isAdmin;
  onMount(()=> {
    edit.subscribe(res => isAdmin = res)
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
        <Above qs={qs}/>
      {/if}
    {/each}
  {:else}
    <p>No questions yet!</p>
  {/if}
    <NewQuestion />
  {/if}
</div>
<style>

  .container {
    width: 80%;
    margin: auto;
  }

</style>
