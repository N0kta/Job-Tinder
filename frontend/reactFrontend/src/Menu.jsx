export default function Tabs({children, buttons, container}) {
    const Container = container;

    return (
        <>
            <Container>{buttons}</Container>
            {children}
        </>
    )
}