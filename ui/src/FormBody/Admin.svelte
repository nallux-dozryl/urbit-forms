<script>
  import { formSettingsTab } from '../UrbitStore'
  import Details from './Details.svelte'
  import Invite from './Invite.svelte'
  import Export from './Export.svelte'
  import SectionEdit from '../FormEdit/SectionEdit.svelte'

  let tab

  formSettingsTab.subscribe(res => tab = res)

</script>

<div class="nav">
  <button 
    class="tab { tab === 'questions' ? 'active' : '' }"
    on:click={()=> formSettingsTab.set("questions")}
    >
    Questions
  </button>
  <button 
    class="tab { tab === 'details' ? 'active' : '' }"
    on:click={()=> formSettingsTab.set("details")}
    >
    Details
  </button>
  <button 
    class="tab { tab === 'invite' ? 'active' : '' }"
    on:click={()=> formSettingsTab.set("invite")}
    >
    Invite
  </button>
  <button 
    class="tab { tab === 'export' ? 'active' : '' }"
    on:click={()=> formSettingsTab.set("export")}
    >
    Export
  </button>

</div>

{#if tab === "details"}
  <Details />
{:else if tab === "questions"}
  <SectionEdit />
{:else if tab === "invite"}
  <Invite />
{:else if tab === "export"}
  <Export />
{/if}

<style>

  .nav {
    display: flex;
    padding-top: 3em;
    margin: auto;
    max-width: 70%;
    gap: 1em;
  }

  .tab {
    flex: 1;
    border: solid 1px #e9e9e9;
    background: white;
    border-radius: 4px;
    padding: 1em;
  }

  .tab:hover {
    background: grey;
    border-color: grey;
    color: white;
  }

  .active {
    background: black;
    border-color: black;
    color: white;
  }

</style>
